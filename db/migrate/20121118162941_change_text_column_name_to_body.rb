class ChangeTextColumnNameToBody < ActiveRecord::Migration
	def change
		rename_column :articles, :text, :html
	end
end
