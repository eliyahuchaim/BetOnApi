class AddOwnerToParty < ActiveRecord::Migration[5.1]
  def change
    add_column :parties, :owner_id, :integer
  end
end
