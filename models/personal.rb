class Personal < ActiveRecord::Base
  establish_connection configurations[:lushun]
  self.table_name = self.table_name.singularize
  self.primary_key = :psnal_cd
  belongs_to :belonging, :foreign_key => :mst_blg_cd
end
