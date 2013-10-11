class AddLocationAndLocationLinkToEvents < ActiveRecord::Migration
  def change
    add_column :events, :location, :string
    add_column :events, :location_link, :string
  end
end
