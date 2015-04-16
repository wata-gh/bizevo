class AssignPmbr < ActiveRecord::Base
  establish_connection configurations[:lushun]
  self.table_name = self.table_name.singularize
  self.primary_keys = :quotn_no, :quotn_ver_no, :asgn_no
  belongs_to :personal, :foreign_key => :mbr_psnal_cd
  belongs_to :quotation, :foreign_key => [:quotn_no, :quotn_ver_no]
  has_many :assign_pmh, :foreign_key => [:quotn_no, :quotn_ver_no, :asgn_no]
  belongs_to :role, :foreign_key => :role_cd

  def serializable_hash(options={})
    options = {
      :only => [
        :quotn_no,
        :quotn_ver_no,
        :asgn_no,
        :mbr_psnal_cd,
        :role_cd,
        :asgn_start_date,
        :asgn_end_date,
      ]
    }.update(options)
    super(options)
  end
end
