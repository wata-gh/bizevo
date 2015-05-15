module Redmine
  class Feeling < ActiveRecord::Base
    include Filterable
    include Bizevo::Helpers::WikiHelper
    include ActionView::Helpers::DateHelper
    establish_connection configurations[:redmine]
    belongs_to :user, :foreign_key => :user_id
    has_many :members, :through => :user
    has_many :comments, -> { where :commented_type => 'Feeling'}, :foreign_key => :commented_id, :dependent => :destroy
    attr_accessor :me

    def description_disp_html
      (self.description.present? ? content_to_html(self.description) : '').html_safe
    end

    def level_pict
      pict = {0 => 'bad', 1 => 'ordinary', 2 => 'good'}[self.level]
      "http://172.23.0.100/redmine/plugin_assets/redmine_niko_cale/images/faces/creator_01/#{pict}.png"
    end
    def to_jsondata
      pict = {0 => 'bad', 1 => 'ordinary', 2 => 'good'}[self.level]
      {
        :id             => self.id,
        :description    => description_disp_html,
        :at             => self.at,
        :level_pict     => level_pict,
        :comments_count => self.comments_count,
        :user => {
          :id        => self.user.id,
          :firstname => self.user.firstname,
          :lastname  => self.user.lastname,
        },
        :comments => self.comments_count == 0 ? [] : self.comments.order(:created_on).map {|c|
          c.me = self.me
          comment = c.comments_disp_html
          u = ::User.find_by :name => c.user.mail.split('@')[0]
          {
            :user => {
              :id             => c.user.id,
              :firstname      => c.user.firstname,
              :lastname       => c.user.lastname,
              :thumbnail_path => u.present? ? u.get_thumbnail_path : '/images/noimage.png'
            },
            :comments => comment,
            :created_on => time_ago_in_words(c.created_on),
            :updated_on => time_ago_in_words(c.updated_on),
            :is_mine => c.is_mine,
          }
        }
      }
    end
  end
end
