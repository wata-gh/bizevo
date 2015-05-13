class CreateOauths < ActiveRecord::Migration
  def self.up
    create_table :oauths do |t|
      t.integer :user_id
      t.integer :provider
      t.string :access_token
      t.timestamps
    end
    add_index :oauths, :user_id
  end

  def self.down
    remove_index :oauths, :user_id
    drop_table :oauths
  end
end
