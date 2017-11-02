# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([{username: "elisings", password: "hi", firstname: "eli", lastname: "goldstein"}, {username: "david", password: "hi", firstname: "david", lastname: "david"},{username: "dj", password: "hi", firstname: "dj", lastname: "delete"}])

eli = User.first
david = User.find_by(username: "david")
dj = User.last

party = Party.create(title: "test party")

Group.create([{party_id: party.id, user_id: eli.id},{party_id: party.id, user_id: david.id},{party_id: party.id, user_id: dj.id}])

Group.create([{party_id: party.id, user_id: david.id},{party_id: party.id, user_id: dj.id}])

bet1 = Bet.create(value: 20, bet_type: "giants will win another game", party_id: party.id)

par = Party.last
payload = {"bet_type" => "knicks will go to the playoffs", "value" => 10, "party_id" => par.id, "start_date" => "2017-10-30", "end_date" => "2017-10-31"}

bet2 = Bet.create_bet(payload)

david_wager = Wager.create(bet_answer: false, user_id: david.id, bet_id: bet1.id)
eli_wager = Wager.create(bet_answer: false, user_id: eli.id, bet_id: bet1.id)
dj_wager = Wager.create(bet_answer: true, user_id: eli.id, bet_id: bet1.id)
