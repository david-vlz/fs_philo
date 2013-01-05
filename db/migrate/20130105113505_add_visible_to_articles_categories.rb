class AddVisibleToArticlesCategories < ActiveRecord::Migration
  def change
    add_column :articles, 	:visible, :boolean, default: false
    add_column :categories,	:visible, :boolean, default: false
  end
end
