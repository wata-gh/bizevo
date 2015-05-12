class DropAccounts < ActiveRecord::Migration
  def self.up
    drop_table :accounts
  end

  def self.down
    create_table :accounts do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :crypted_password
      t.string :role
      t.timestamps
    end
  end
end
