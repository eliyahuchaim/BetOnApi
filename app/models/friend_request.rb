class FriendRequest < ApplicationRecord
  validate :non_duplicates, :on => :create


  def non_duplicates
    for request in FriendRequest.all
      errors.add(:request, "User already sent friend request") if request.from_user_id == from_user_id && request.to_user_id == to_user_id
    end
  end


  def self.update_request request_id, accepted
    @request = FriendRequest.find(request_id)
    if accepted == 'true' && @request.pending
      @friend = Friend.create(user1: @request.from_user_id, user2: @request.to_user_id)
      @request.update(accepted: true, pending: false)
    elsif accepted == 'false' && @request.pending
      @request.update(accepted: false, pending: false)
    end
    @friend ? @friend : @request
  end


end
