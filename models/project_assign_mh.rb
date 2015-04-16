class ProjectAssignMh < ActiveRecord::Base
  establish_connection configurations[:lushun]
  self.table_name = self.table_name.singularize
  self.primary_key = [:setup_date_ym, :asgn_no, :prj_cd]
  belongs_to :project_assign, :foreign_key => [:prj_cd, :asgn_no]

  def serializable_hash(options={})
    options = {
      :only => [:setup_date_ym, :man_hour_mm, :asgn_no, :prj_cd]
    }.update(options)
    super(options)
  end
end
