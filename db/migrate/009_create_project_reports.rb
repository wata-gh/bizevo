class CreateProjectReports < ActiveRecord::Migration
  def self.up
    create_table :project_reports do |t|
      t.integer :quotn_no, :null => false, :limit => 8
      t.text :report
      t.string :report_psnal_cd, :null => false, :limit => 10
      t.timestamps
    end
    add_index :project_reports, :quotn_no
  end

  def self.down
    drop_table :project_reports
  end
end
