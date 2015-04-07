class ChangeColumnArticle < ActiveRecord::Migration
  def self.up
    change_column :articles, :article, :text
  end

  def self.down
  end
end
