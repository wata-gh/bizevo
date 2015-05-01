module Redmine
  class Member < ActiveRecord::Base
    establish_connection configurations[:redmine]
    belongs_to :user, :foreign_key => :user_id
    belongs_to :project, :foreign_key => :project_id
  end
end
