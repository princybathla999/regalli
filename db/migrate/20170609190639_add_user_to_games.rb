class AddUserToGames < ActiveRecord::Migration
  def change
    add_reference :games, :user, foreign_key: true
  end
end
