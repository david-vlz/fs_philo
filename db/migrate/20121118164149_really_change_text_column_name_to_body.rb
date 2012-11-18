class ReallyChangeTextColumnNameToBody < ActiveRecord::Migration
	def change
		rename_column :articles, :html, :body
	end
end
