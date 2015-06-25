
module Tea
  class Party < ActiveRecord::Base
    self.table_name = :tea_parties
    self.primary_key = :id

    validates :title, length: { minimum: 1 }

    belongs_to  :owner, class_name: 'Tea::User', primary_key: 'id'
    has_many    :likes, ->{order(created_at: :asc)}, class_name: 'Tea::Like', foreign_key: 'id'
    has_many    :comments, ->{order(created_at: :asc)}, class_name: 'Tea::Comment', foreign_key: 'parent_id'
    has_many    :attends, ->{order(created_at: :asc)}, class_name: 'Tea::PartyAttend', foreign_key: 'id'

    scope :owner_by, -> (user) { where(owner: user.id) }
    scope :alived, -> { where(Party.wip.recruitment.feedback.where_values.reduce(:or)) }

    enum status: [:unsaved, :draft, :wip, :recruitment, :feedback, :closed]

    def image
      self.image_path ? "http://#{S3_CONFIG['host']}/thumbnail/#{self.image_path}.png" : "/images/noimage.png"
    end

    def update_date
      self.updated_at
    end

    def self.create_new_party! owner
      p = self.new id: Id.new_id_as_party, owner_id: owner.id, title: '未保存の勉強会', capacity: 0
      p.unsaved!
      p.save!
      p
    end
  end
end
