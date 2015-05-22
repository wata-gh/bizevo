module Redmine
  class JournalDetail < ActiveRecord::Base
    establish_connection configurations[:redmine]
    belongs_to :journal
  end
end
