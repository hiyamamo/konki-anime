class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :tv_station
      t.datetime :started_at
      t.references :program, index: true

      t.timestamps
    end
  end
end
