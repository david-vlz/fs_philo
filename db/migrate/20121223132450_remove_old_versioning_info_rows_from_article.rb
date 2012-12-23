class RemoveOldVersioningInfoRowsFromArticle < ActiveRecord::Migration
  def up
    remove_column :articles, :modifier
    remove_column :articles, :version
  end

  def down
    add_column :articles, :version, :integer
    add_column :articles, :modifier, :string
  end
end
