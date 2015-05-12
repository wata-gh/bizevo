class RenameLike < ActiveRecord::Migration
  def self.up
    rename_column :articles, :like, :likes
  end

  def self.down
    rename_column :articles, :likes, :like
  end
end
