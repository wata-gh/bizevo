class Project < ActiveRecord::Base
  establish_connection configurations[:lushun]
  self.table_name = self.table_name.singularize
  belongs_to :quotation, :foreign_key => [:latest_ver_quotn_no, :latest_ver_quotn_ver_no]
end
