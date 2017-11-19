
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

  def self.check_if_group_has_user party_id, user_id
    result = @@connection.execute(%Q{
      SELECT * FROM groups
      WHERE party_id=#{@@connection.quote(party_id)}
      AND user_id=#{@@connection.quote(user_id)}})

      result.values.length > 0 ? true : false
  end

  def self.top_users
    result = @@connection.execute(%Q{
      SELECT username, id, points
      FROM users
      ORDER BY points DESC
    })
    result.values.map {|u| {id: u[1], username: u[0], points: u[2]}}
  end

end
