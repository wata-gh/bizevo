class Sale < ActiveRecord::Base
  establish_connection configurations[:lushun]
end
