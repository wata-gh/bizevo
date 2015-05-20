module Libra
  class EstimateContract < ActiveRecord::Base
    establish_connection configurations[:"libra_#{Padrino.env}"]
    self.table_name = self.table_name.singularize
    self.primary_key = :ord_id
    belongs_to :ord
  end
end
