module Libra
  class EstimateQuasiMandatePersonnel < ActiveRecord::Base
    establish_connection configurations[:"libra_#{Padrino.env}"]
    self.table_name = self.table_name.singularize
    self.primary_keys = :ord_id, :order_no
    belongs_to :ord
  end
end
