class AddDisplyToCategoriesAndArticles < ActiveRecord::Migration
  def change
    add_column :categories, :display, :boolean
    add_column :articles, :display, :boolean
  end
end
