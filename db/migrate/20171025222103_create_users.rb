class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :password_digest
      t.integer :points, default: 100
      
      t.timestamps
    end
  end
end
