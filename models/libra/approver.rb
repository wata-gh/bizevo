module Libra
  class Approver < ActiveRecord::Base
    establish_connection configurations[:"libra_#{Padrino.env}"]
    self.table_name = self.table_name.singularize
    self.primary_keys = :order_no, :approval_request_no
    belongs_to :approval_request, :foreign_key => :approval_request_no
  end
end
