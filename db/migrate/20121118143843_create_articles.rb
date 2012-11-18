class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :creator
      t.timestamp :created
      t.text :text
      t.integer :version
      t.string :modifier
      t.timestamp :modified
      t.boolean :active

      t.timestamps
    end
  end
end
