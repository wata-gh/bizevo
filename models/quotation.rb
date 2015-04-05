class Quotation < ActiveRecord::Base
  establish_connection configurations[:lushun]
  self.table_name = self.table_name.singularize
  self.primary_keys = :quotn_no, :quotn_ver_no

  # relations
  belongs_to :belonging, :foreign_key => :main_group_mst_blg_cd
  belongs_to :csc_cust, :class_name => :Cust, :foreign_key => :csc_cust_cd, :primary_key => :cust_cd
  has_many :assign_pmbrs, :foreign_key => [:quotn_no, :quotn_ver_no]
  has_many :sales, :foreign_key => :quotn_no, :primary_key => :quotn_no
  has_one :project, :foreign_key => [:latest_ver_quotn_no, :latest_ver_quotn_ver_no]
  has_one :sales_assoc, :class_name => :Personal, :foreign_key => :psnal_cd, :primary_key => :sales_assoc_psnal_cd
  has_one :tech_assoc, :class_name => :Personal, :foreign_key => :psnal_cd, :primary_key => :tech_assoc_psnal_cd

  # enums
  enum cntrct_tp: {lump_sum: '1', mandate: '2', worker_dispatch: '3', maintenance: '4'}

  # scopes
  scope :current_month, ->(m) {
   where(<<-"EOS"
    (quotation.start_date < '#{m}' and quotation.end_date > '#{m}99')
    or (quotation.start_date > '#{m}' and quotation.end_date < '#{m}99')
    or (quotation.start_date > '#{m}' and quotation.end_date > '#{m}99')
    or (quotation.start_date < '#{m}' and quotation.end_date > '#{m}99')
   EOS
   ).order([:main_group_mst_blg_cd, :pcu_cd, :quotn_no])
  }

  def cntrct_tp_color
    return 'blue' if self.lump_sum?
    return 'green' if self.mandate?
    return 'yellow' if self.worker_dispatch?
    return 'orange' if self.maintenance?
    'black'
  end
end
