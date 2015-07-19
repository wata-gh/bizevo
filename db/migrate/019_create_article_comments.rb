class CreateArticleComments < ActiveRecord::Migration
  def self.up
    create_table :article_comments do |t|
      t.integer :article_id
      t.integer :user_id
      t.text :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :article_comments
  end
end
