class AddFieldToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :mst_blg_cd, :string
    add_column :users, :full_name, :string
  end

  def self.down
    remove_column :users, :mst_blg_cd
    remove_column :users, :full_name, :string
  end
end
