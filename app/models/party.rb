class Party < ApplicationRecord
  has_many :bets
  has_many :groups
  has_many :users, through: :groups


  def self.create_party owner_id, title
    @party = Party.create(title: title, owner_id: owner_id)
    Group.create(party_id: @party.id, user_id: owner_id)
    @party.id ? @party : false
  end

  def self.invite_people_to_party party_id, invited_user_id, owner_id
    @party = Party.find(party_id)
    if @party.owner_id == owner_id.to_i
      Group.create(party_id: party_id.to_i, user_id: invited_user_id.to_i)
    else
      false
    end
  end

  def self.mass_invite party_id, users_arr, owner_id
    for user in users_arr
      check = self.invite_people_to_party party_id, user.to_i, owner_id
    end
    false unless check
  end


end
