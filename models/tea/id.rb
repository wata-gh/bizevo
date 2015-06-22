module Tea
  class Id < ActiveRecord::Base
    self.table_name = 'tea_ids'

    def self.new_id_as_party
      self.new_id 'Party'
    end

    def self.new_id_as_comment
      self.new_id 'Comment'
    end

    private
    def self.new_id kind = 'UNKNOWN'
      self.create(id_kind: kind).id
    end

  end
end
