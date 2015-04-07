class MaintContract < ActiveRecord::Base
  establish_connection configurations[:lushun]
  self.table_name = self.table_name.singularize
  belongs_to :quotation, :foreign_key => [:quotn_no, :quotn_ver_no]
end
