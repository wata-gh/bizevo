class AddLike < ActiveRecord::Migration
  def self.up
    add_column :articles, :like, :integer
    Article.all.update_all(like: 0)
  end

  def self.down
    remove_column :articles, :like, :integer
  end
end
