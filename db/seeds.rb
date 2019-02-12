# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


10.times do 
	User.create(
		name: Faker::Name.first_name,
		email: Faker::Internet.email,
		password: 'foobar',
		password_confirmation: 'foobar',
		activated: true
		)
end

User.create(
	name: "Torrey",
	email: "torrey@email.com",
	password: 'foobar',
	password_confirmation: 'foobar',
	activated: true
		)

5.times do 
	sender = rand(1..10)
	FriendRequest.create( 
		sender_id: sender,
		receiver_id: 11
		)
	FriendRequest.create(
		sender_id: 11,
		receiver_id: sender
		)
		
end

100.times do
	author = rand(1..11)
	Post.create(
		author_id: author,
		content: "hey buddy pal")
end