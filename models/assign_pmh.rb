class AssignPmh < ActiveRecord::Base
  establish_connection configurations[:lushun]
  self.table_name = self.table_name.singularize
  belongs_to :assign_pmbr, :foreign_key => :asgn_no
end
