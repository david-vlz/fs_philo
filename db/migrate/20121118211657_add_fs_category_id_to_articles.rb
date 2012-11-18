class AddFsCategoryIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :fs_category_id, :integer
  end
end
