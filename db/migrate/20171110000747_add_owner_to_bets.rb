class AddOwnerToBets < ActiveRecord::Migration[5.1]
  def change
    add_column :bets, :owner_id, :integer
  end
end
