class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :creator
      t.text :text
      t.integer :version
      t.string :modifier
      t.boolean :active

      t.timestamps
    end
  end
end
