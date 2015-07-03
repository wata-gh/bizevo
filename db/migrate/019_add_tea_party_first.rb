class AddTeaPartyFirst < ActiveRecord::Migration
  def self.up
    create_table :tea_ids do |t|
      t.string    :id_kind,      null: false, limit: 128
      t.timestamps
    end

    create_table :tea_parties, id: false do |t|
      t.integer   :id,          null: false
      t.integer   :status,      null: false
      t.integer   :owner_id,    null: false
      t.string    :image_path
      t.string    :title
      t.string    :description
      t.datetime  :start_date
      t.string    :venue
      t.string    :reseration
      t.integer   :capacity
      t.timestamps
    end
    add_index :tea_parties, [:id], unique: true

    create_table :tea_likes, id: false do |t|
      t.integer   :id,          null: false
      t.integer   :user_id,     null: false
      t.timestamps
    end
    add_index :tea_likes, [:id, :user_id], unique: true

    create_table :tea_comments, id: false do |t|
      t.integer   :id,          null: false
      t.integer   :parent_id,   null: false
      t.text      :text,        null: false
      t.integer   :user_id,     null: false
      t.timestamps
    end
    add_index :tea_comments, [:id], unique: true

    create_table :tea_party_attends, id: false do |t|
      t.integer   :id,          null: false
      t.integer   :user_id,     null: false
      t.timestamps
    end
    add_index :tea_party_attends, [:id, :user_id], unique: true

  end

  def self.down
    drop_table :tea_ids
    drop_table :tea_parties
    drop_table :tea_likes
    drop_table :tea_comments
    drop_table :tea_party_attends
  end
end
