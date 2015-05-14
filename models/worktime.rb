class Worktime < ActiveRecord::Base
  belongs_to :user, :foreign_key => :psnal_cd, :primary_key => :psnal_cd
end
