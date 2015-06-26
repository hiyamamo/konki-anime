class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :title
      t.string :url
      t.references :season, index: true

      t.timestamps
    end
  end
end
