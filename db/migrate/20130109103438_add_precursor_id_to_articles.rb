class AddPrecursorIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :precursor_id, :integer
  end
end
