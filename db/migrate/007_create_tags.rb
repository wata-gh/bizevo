class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags, id: false do |t|
      t.string :tag
      t.integer :delete_flg
      t.timestamps
    end
    add_index :tags, :tag, unique: true
  end

  def self.down
    drop_table :tags
  end
end
