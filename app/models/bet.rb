class Bet < ApplicationRecord
  belongs_to :party
  has_many :wagers
end
