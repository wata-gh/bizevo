module Redmine
  class Journal < ActiveRecord::Base
    enum :journalized_type => {
      :issue => 'Issue',
    }
    establish_connection configurations[:redmine]
    belongs_to :user, :foreign_key => :user_id
    belongs_to :issue, :foreign_key => :journalized_id
    has_many :journal_details
  end
end
