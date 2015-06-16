class CreateWatchLists < ActiveRecord::Migration
  def change
    create_table :watch_lists do |t|
      t.integer :user_id
			t.integer :program_id
      t.string :title
      t.string :tv_station
      t.datetime :started_at
			t.string :season

      t.timestamps
    end
  end
end
