class AddDefaultLike < ActiveRecord::Migration
  def self.up
    change_column :articles, :likes, :integer, :default => 0
  end

  def self.down
    change_column :articles, :likes, :integer, :default => nil
  end
end
