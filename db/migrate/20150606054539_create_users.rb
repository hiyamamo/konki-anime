class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid
      t.string :name
			t.text :img_url
      t.string :screen_name
      t.text :access_token
      t.text :access_token_secret
      t.string :provider

      t.timestamps
    end
  end
end
