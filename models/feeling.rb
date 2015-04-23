class Feeling < ActiveRecord::Base
  establish_connection configurations[:redmine]
  belongs_to :redmine_user, :foreign_key => :user_id
  has_many :comments, -> { where :commented_type => 'Feeling'}, :foreign_key => :commented_id

  def to_jsondata
    extensions = {
      :fenced_code_blocks => true,
      :tables => true,
    }
    redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions)
    pict = {0 => 'bad', 1 => 'ordinary', 2 => 'good'}[self.level]
    {
      :id          => self.id,
      # :description => f.description.gsub(/(.+)\r\n/, "\\1  \r\n"),
      #:description => redcarpet.render(self.description.gsub(/(.+)\r\n/, "\\1  \r\n")).gsub(/^\r\n$/, '<br>'),
      :description => self.description.gsub(/\r\n|\r|\n/, "<br />"),
      :at => self.at,
      :level_pict => "http://172.23.0.100/redmine/plugin_assets/redmine_niko_cale/images/faces/creator_01/#{pict}.png",
      :user => {
        :id        => self.redmine_user.id,
        :firstname => self.redmine_user.firstname,
        :lastname  => self.redmine_user.lastname,
      },
      :comments => self.comments.map {|c|
        {
          :user => {
            :id        => c.redmine_user.id,
            :firstname => c.redmine_user.firstname,
            :lastname  => c.redmine_user.lastname,
          },
          :comments => c.comments.gsub(/\r\n|\r|\n/, "<br />"),
          :created_on => c.created_on,
          :updated_on => c.updated_on,
        }
      }
    }
  end
end
