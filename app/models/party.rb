class Party < ApplicationRecord
  has_many :bets
  has_many :groups
  has_many :users, through: :groups
end
