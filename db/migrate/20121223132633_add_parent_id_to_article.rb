class AddParentIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :parent_id, :integer
  end
end
