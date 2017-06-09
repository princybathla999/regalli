class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :date
      t.integer :opponent
      t.integer :my_score
      t.integer :opponent_score

      t.timestamps null: false
    end
  end
end
