class CreateBets < ActiveRecord::Migration[5.1]
  def change
    create_table :bets do |t|
      t.string :bet_type
      t.integer :value
      t.boolean :result
      t.boolean :ended
      t.integer :party_id
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
