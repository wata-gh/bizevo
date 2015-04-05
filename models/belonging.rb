class Belonging < ActiveRecord::Base
  establish_connection configurations[:lushun]
  self.table_name = self.table_name.singularize

  def self.business_blg
    where(:blg_layer => 2, :orgn_catgry_a => '02').where("orgn_catgry_b > '0001' and orgn_catgry_b < '0008'")
  end
end
