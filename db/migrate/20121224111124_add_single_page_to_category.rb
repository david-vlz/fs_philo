class AddSinglePageToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :single_page, :boolean
  end
end
