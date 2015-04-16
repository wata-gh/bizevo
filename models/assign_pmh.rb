class AssignPmh < ActiveRecord::Base
  establish_connection configurations[:lushun]
  self.table_name = self.table_name.singularize
  self.primary_key = [:setup_date_ym, :quotn_no, :quotn_ver_no, :asgn_no]
  belongs_to :assign_pmbr, :foreign_key => [:quotn_no, :quotn_ver_no, :asgn_no]

  def serializable_hash(options={})
    options = {
      :only => [:setup_date_ym, :man_hour_mm, :asgn_no, :quotn_no, :quotn_ver_no]
    }.update(options)
    super(options)
  end
end
