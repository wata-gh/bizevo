module Libra
  class ApprovalRequest < ActiveRecord::Base
    establish_connection configurations[:"libra_#{Padrino.env}"]
    self.table_name = self.table_name.singularize
    self.primary_key = :approval_request_no
    belongs_to :ord
    has_many :approvers, :foreign_key => :approval_request_no
    enum :approval_request_kbn => {:quotn => '1 '}
    enum :approval_cd => {:not_yet => 0, :approve => 1, :denial => 2}

    def approval_cd_i18n
      ApprovalRequest.translate_enum_label self.class, 'approval_cd', self.approval_cd
    end

  end
end
