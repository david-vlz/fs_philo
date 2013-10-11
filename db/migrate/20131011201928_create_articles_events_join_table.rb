class CreateArticlesEventsJoinTable < ActiveRecord::Migration
  def up
  	create_table :articles_events, id: false do |t|
  		t.integer :article_id
  		t.integer :event_id
		end
  end

  def down
  	drop_table :articles_events
  end
end
