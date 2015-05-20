module Libra
  class Ord < ActiveRecord::Base
    enum :contract_class => {
        :contract      => '1',
        :quasi_mandate => '2',
      }
    establish_connection configurations[:"libra_#{Padrino.env}"]
    self.table_name = self.table_name.singularize
    self.primary_key = :ord_id
    has_one :approval_request
    has_one :estimate_contract
    has_one :estimate_quasi_mandate
    has_many :estimate_quasi_mandate_personnels
  end
end
