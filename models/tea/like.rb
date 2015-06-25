
module Tea
  class Like < ActiveRecord::Base
    self.table_name = :tea_likes
    self.primary_key = :id, :user_id

    belongs_to :user, class_name: 'Tea::User'
    belongs_to :party, class_name: 'Tea::Party', foreign_key: 'id'
    belongs_to :comment, class_name: 'Tea::Comment', foreign_key: 'id'

    scope :liked_for, -> (id) { where(id: id) }
  end
end
