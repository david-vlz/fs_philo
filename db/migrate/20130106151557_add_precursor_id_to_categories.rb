class AddPrecursorIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :precursor_id, :integer
  end
end
