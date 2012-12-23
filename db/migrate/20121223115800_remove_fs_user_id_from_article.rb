class RemoveFsUserIdFromArticle < ActiveRecord::Migration
  def up
    remove_column :articles, :fs_user_id
  end

  def down
    add_column :articles, :fs_user_id, :integer
  end
end
