class RemoveDeleteFlgFromTags < ActiveRecord::Migration
  def self.up
    remove_column :tags, :delete_flg
  end

  def self.down
    add_column :tags, :delete_flg, :integer, after: :tag
  end
end
