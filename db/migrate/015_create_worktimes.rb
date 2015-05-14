class CreateWorktimes < ActiveRecord::Migration
  def self.up
    create_table :worktimes do |t|
      t.string :psnal_cd,        :null => false
      t.date   :date,            :null => false
      t.string :calendar,        :null => false
      t.string :absence,         :null => false
      t.string :work_class,      :null => false
      t.string :start,           :null => false
      t.string :start_mc,        :null => false
      t.string :end,             :null => false
      t.string :end_mc,          :null => false
      t.string :going_out,       :null => false
      t.string :going_out_mc,    :null => false
      t.string :return,          :null => false
      t.float  :worked_hours,    :null => false
      t.float  :l_worked_hours,  :null => false
      t.float  :h_worked_hours,  :null => false
      t.float  :hl_worked_hours, :null => false
      t.float  :tardy_hours,     :null => false
      t.float  :early_hours,     :null => false
      t.float  :private_hours,   :null => false

      t.timestamps
    end
    add_index :worktimes, :date
    add_index :worktimes, :psnal_cd
  end

  def self.down
    remove_index :worktimes, :date
    remove_index :worktimes, :psnal_cd
    drop_table :worktimes
  end
end
