class CreateArticleTags < ActiveRecord::Migration
  def self.up
    create_table :article_tags, id: false do |t|
      t.integer :article_id
      t.string :tag
      t.integer :delete_flg
      t.timestamps
    end
    add_index :article_tags, [:article_id, :tag], unique: true
  end

  def self.down
    drop_table :article_tags
  end
end
