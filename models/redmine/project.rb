module Redmine
  class Project < ActiveRecord::Base
    establish_connection configurations[:redmine]
    has_many :redmine_users
  end
end
