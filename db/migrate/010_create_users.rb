class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :psnal_cd
      t.string :icon_path
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
