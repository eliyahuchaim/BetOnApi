class ChangeColumnInWager < ActiveRecord::Migration[5.1]
  def change
    change_table :wagers do |t|
      t.rename :bet, :bet_answer
    end
  end
end
