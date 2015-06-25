class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :value, :null => false
			t.boolean :current, :default => false

      t.timestamps
    end
  end
end
