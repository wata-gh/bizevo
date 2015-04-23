class Comment < ActiveRecord::Base
  establish_connection configurations[:redmine]
  belongs_to :redmine_user, :foreign_key => :author_id
  belongs_to :feeling, -> { where :commented_type => 'Feeling'}, :foreign_key => :commented_id
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
      :description => redcarpet.render(self.description.gsub(/(.+)\r\n/, "\\1  \r\n")).gsub(/^\r\n$/, '<br>'),
      :at => self.at,
      :level_pict => "http://172.23.0.100/redmine/plugin_assets/redmine_niko_cale/images/faces/creator_01/#{pict}.png",
      :user => {
        :id        => self.redmine_user.id,
        :firstname => self.redmine_user.firstname,
        :lastname  => self.redmine_user.lastname,
      }
    }
  end
end
