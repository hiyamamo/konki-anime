class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :title
      t.string :url
      t.integer :vote, default: 0
      t.references :season, index: true

      t.timestamps
    end
  end
end
