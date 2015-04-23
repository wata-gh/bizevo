class RedmineUser < ActiveRecord::Base
  establish_connection configurations[:redmine]
  self.table_name = :users
  self.inheritance_column = :_type_disabled
  has_many :feelings
end
