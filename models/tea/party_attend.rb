
module Tea
  class PartyAttend < ActiveRecord::Base
    self.table_name = :tea_party_attends
    self.primary_key = :id, :user_id

    belongs_to :user, class_name: 'Tea::User'
    belongs_to :party, class_name: 'Tea::Party', primary_key: 'id'

    scope :attended_for, -> (id) { where(id: id) }
  end
end
