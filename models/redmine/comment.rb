module Redmine
  class Comment < ActiveRecord::Base
    include Bizevo::Helpers::WikiHelper
    include ActionView::Helpers::DateHelper
    establish_connection configurations[:redmine]
    belongs_to :user, :foreign_key => :author_id
    belongs_to :feeling, -> { where :commented_type => 'Feeling'}, :foreign_key => :commented_id
    attr_accessor :me

    def comments_disp_html
      self.comments.present? ? content_to_html(self.comments) : ''
    end

    def created_on_words
      time_ago_in_words self.created_on
    end

    def is_mine
      self.author_id == me
    end
  end
end
