class Group < ApplicationRecord
  belongs_to :party
  belongs_to :user
  validate :validate_user_not_in_group

  def validate_user_not_in_group
    result = UserQueries.check_if_group_has_user party_id, user_id
    result ? errors.add(:user_id, "user is already in this party") : true
  end


end
