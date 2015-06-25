class CreateWatchLists < ActiveRecord::Migration
  def change
    create_table :watch_lists do |t|
      t.integer :user_id
			t.integer :program_id, :index => true
			t.integer :detail_id, :index => true

      t.timestamps
    end
  end
end
