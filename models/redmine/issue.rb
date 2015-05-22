module Redmine
  class Issue < ActiveRecord::Base
    establish_connection configurations[:redmine]
    belongs_to :user, :foreign_key => :author_id
    belongs_to :project, :foreign_key => :project_id
    has_many :journals, -> { where :journalized_type => 'Issue'}, :foreign_key => :journalized_id
  end
end
