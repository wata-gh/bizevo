module Redmine
  class Comment < ActiveRecord::Base
    include Bizevo::Helpers::WikiHelper
    establish_connection configurations[:redmine]
    belongs_to :user, :foreign_key => :author_id
    belongs_to :feeling, -> { where :commented_type => 'Feeling'}, :foreign_key => :commented_id

    def comments_disp_html
      self.comments.present? ? content_to_html(self.comments) : ''
    end
  end
end
