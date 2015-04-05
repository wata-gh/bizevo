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
  enum order_stat: {
    not_yet_started:                 '20',
    lost_before_start:               '29',
    expected_start:                  '30',
    preceding_start:                 '35',
    purchase_order_received:         '40',
    completion_certificate_received: '45',
    invoices_issued:                 '50',
    payment_confirmed:               '60',
    lost:                            '80',
    refuse:                          '90',
    exit_on_the_way:                 '95',
  }

  # scopes
  scope :current_month, ->(m) {
   where(<<-"EOS"
    (quotation.start_date < '#{m}' and quotation.end_date > '#{m}99')
    or (quotation.start_date > '#{m}' and quotation.end_date < '#{m}99')
    or (quotation.start_date > '#{m}' and quotation.end_date > '#{m}99')
    or (quotation.start_date < '#{m}' and quotation.end_date > '#{m}99')
   EOS
   ).includes(:project, :csc_cust, :assign_pmbrs)
    .references(:project, :csc_cust, :assign_pmbrs)
    .order(:main_group_mst_blg_cd, :pcu_cd, :quotn_no)
  }

  def cntrct_tp_color
    return 'blue' if self.lump_sum?
    return 'green' if self.mandate?
    return 'yellow' if self.worker_dispatch?
    return 'orange' if self.maintenance?
    'black'
  end

  def order_stat_color
    return 'blue' if self.expected_start? || self.preceding_start? || self.purchase_order_received?
    return 'green' if self.purchase_order_received? || self.completion_certificate_received? || self.invoices_issued? || self.payment_confirmed?
    return 'red' if self.exit_on_the_way?
    return 'black' if self.lost?
    ''
  end

  def man_hour_mm month
    assign_pmbrs.inject(0) do |s, m|
      pmh = m.assign_pmh.find_by :setup_date_ym => month
      s + (pmh.present? ? pmh.man_hour_mm : 0)
    end
  end

  def order_stat_i18n
    Quotation.translate_enum_label self.class, 'order_stat', self.order_stat
  end

  def cntrct_tp_i18n
    Quotation.translate_enum_label self.class, 'cntrct_tp', self.cntrct_tp
  end

  def self.translate_enum_label(klass, attr_name, enum_label)
    ::I18n.t("enums.#{klass.to_s.underscore}.#{attr_name}.#{enum_label}", default: enum_label)
  end
end
