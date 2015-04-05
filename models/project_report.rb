class ProjectReport < ActiveRecord::Base
  validates :quotn_no, :presence => true
  validates :report_psnal_cd, :presence => true
  validates :report, :presence => true
end
