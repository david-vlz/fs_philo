class RemoveOldVersionFieldsFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :active
    remove_column :articles, :parent_id
  end

  def down
    add_column :articles, :parent_id, :integer
    add_column :articles, :active, :boolean
  end
end
