class RemoveFsCategoryIdFromArticle < ActiveRecord::Migration
  def up
    remove_column :articles, :fs_category_id
  end

  def down
    add_column :articles, :fs_category_id, :integer
  end
end
