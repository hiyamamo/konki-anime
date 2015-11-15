class AddVoteColumn < ActiveRecord::Migration
  def change
    add_column :programs, :vote, :integer, :default => 0
  end
end
