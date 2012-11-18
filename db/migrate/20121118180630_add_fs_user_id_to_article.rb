class AddFsUserIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :fs_user_id, :integer
  end
end
