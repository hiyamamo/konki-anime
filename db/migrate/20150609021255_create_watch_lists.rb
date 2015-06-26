class CreateWatchLists < ActiveRecord::Migration
  def change
    create_table :watch_lists do |t|
      t.integer :user_id
			t.integer :detail_id, :index => true

      t.timestamps
    end
  end
end
