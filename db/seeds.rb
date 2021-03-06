# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Example User",
			 email: "example@example.com",
			 password: "foobar",
			 password_confirmation: "foobar")


10.times do |i|
	name = Faker::Name.name 
	email = "example_#{i+1}@example.com" 
	User.create!(name: name,
				 email: email,
				 password: "password",
				 password_confirmation: "password")
	Post.create!(text: "Hello my name is #{name}", user_id: User.last.id)
end

