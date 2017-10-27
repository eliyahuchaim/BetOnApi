class CreateWagers < ActiveRecord::Migration[5.1]
  def change
    create_table :wagers do |t|
      t.boolean :bet
      t.integer :user_id
      t.integer :bet_id

      t.timestamps
    end
  end
end
