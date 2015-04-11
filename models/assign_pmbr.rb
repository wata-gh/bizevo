class AssignPmbr < ActiveRecord::Base
  establish_connection configurations[:lushun]
  self.table_name = self.table_name.singularize
  self.primary_keys = :quotn_no, :quotn_ver_no, :asgn_no
  belongs_to :personal, :foreign_key => :mbr_psnal_cd
  belongs_to :quotation, :foreign_key => [:quotn_no, :quotn_ver_no]
  has_many :assign_pmh, :foreign_key => [:quotn_no, :quotn_ver_no, :asgn_no]
end
