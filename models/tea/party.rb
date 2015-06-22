
module Tea
  class Party < ActiveRecord::Base
    self.table_name = :tea_parties
    self.primary_key = :id

    belongs_to  :owner, class_name: 'Tea::User', foreign_key: 'owner_id', primary_key: 'id'
    has_many    :likes, ->{order(created_at: :asc)}, class_name: 'Tea::Like', foreign_key: 'id', primary_key: 'id'
    has_many    :comments, ->{order(created_at: :asc)}, class_name: 'Tea::Comment', foreign_key: 'parent_id', primary_key: 'id'
    has_many    :attends, ->{order(created_at: :asc)}, class_name: 'Tea::PartyAttend', foreign_key: 'id', primary_key: 'id'

    scope :owner_by, -> (user) { where(owner: user.id) }
    scope :unsaved, -> { where(status: Status::UNSAVED) }
    scope :alived, -> { where.not(status: [Status::UNSAVED, Status::CLOSED]) }

    def image
      self.image_path ? "http://#{S3_CONFIG['host']}/thumbnail/#{self.image_path}.png" : "/images/noimage.png"
    end

    def update_date
      self.updated_at
    end

    def self.create_new_party! owner
      self.create! id: Id.new_id_as_party, status: Status::UNSAVED, owner_id: owner.id
    end

    module Status
      UNSAVED = 1
      DRAFT = 2
      WIP = 3
      RECRUITMENT = 4
      FEEDBACK = 5
      CLOSED = 6
    end
  end
end
