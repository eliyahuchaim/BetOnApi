class Wager < ApplicationRecord
  belongs_to :user
  has_one :bet
end
