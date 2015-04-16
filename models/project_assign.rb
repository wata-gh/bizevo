class ProjectAssign < ActiveRecord::Base
  establish_connection configurations[:lushun]
  self.table_name = self.table_name.singularize
  self.primary_keys = :prj_cd, :asgn_no
  belongs_to :personal, :foreign_key => :asgn_psnal_cd
  belongs_to :project, :foreign_key => :prj_cd
  has_many :project_assign_mh, :foreign_key => [:prj_cd, :asgn_no], :dependent => :destroy
  belongs_to :role, :foreign_key => :role_cd
end
