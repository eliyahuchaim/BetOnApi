
class UserQueries
  @@connection = ActiveRecord::Base.connection

  def self.find_friends(user_id)
    result = @@connection.execute(%Q{
    SELECT * FROM friends WHERE user1=#{@@connection.quote(user_id)} OR user2=#{@@connection.quote(user_id)}})
    friends_list = []
    for a in result.values
      if a[1] != user_id
        friends_list.push(User.find(a[1]))
      else
        friends_list.push(User.find(a[2]))
      end
    end
    friends_list
  end



end
