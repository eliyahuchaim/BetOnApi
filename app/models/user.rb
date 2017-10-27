class User < ApplicationRecord
  has_secure_password
  has_many :groups
  has_many :parties, through: :groups
  has_many :wagers

end
