class Belonging < ActiveRecord::Base
  establish_connection configurations[:lushun]
  self.table_name = self.table_name.singularize
end
