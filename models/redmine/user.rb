module Redmine
  class User < ActiveRecord::Base
    establish_connection configurations[:redmine]
    self.table_name = :users
    self.inheritance_column = :_type_disabled
    has_many :feelings
    has_many :members

    def full_name
      "#{self.lastname} #{self.firstname}"
    end
  end
end
