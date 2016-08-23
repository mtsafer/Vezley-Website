# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#  User.create!(name:  "Example User",
#             email: "example@railstutorial.org",
#             password:              "foobar",
#             password_confirmation: "foobar",
#             mod: 1,
#             activated: true,
#             activated_at: Time.zone.now)
#
#  User.create!(name:  "Martin Safer",
#             email: "mtsafer@gmail.com",
#             password:              "Crazymonkey1993",
#             password_confirmation: "Crazymonkey1993",
#             mod: 1,
#             activated: true,
#             activated_at: Time.zone.now)
#
#  99.times do |n|
#  name  = Faker::Name.name
#  email = "example-#{n+1}@railstutorial.org"
#  password = "password"
#  User.create!(name:  name,
#               email: email,
#               password:              password,
#               password_confirmation: password,
#               activated: true,
#               activated_at: Time.zone.now)
#  end

Subject.create(name: "content")
Subject.create(name: "technology")
Subject.create(name: "games")
Subject.create(name: "general")

InfoBlock.create(name: "schedule", title: "schedule", 
  body: "--Generally around 6 EST--

Main Casts (95% chance of cast): Tuesday, Friday, Sunday

Possible Extra Casts (70% chance of cast): Wednesday, Saturday

Days off (15% chance of cast): Monday, Thursday")

InfoBlock.create(name: "about_me", title: "about me",
  body: "My name is Vezley - I enjoy gaming and playing the piano along with a little anime on the side. I am unsure what my future holds but I plan to keep an open mind.

As for being a caster on twitch - I hope to at least get a quality button to ensure stability for all my viewers.

The Vezzelution - simply a revolution that I'm starting here on twitch. To fight against anything and everything in life that brings you down. I want you to come in here and know you have a family. The Vezzelution isn't about me, but about all of us as a whole - I simply started it.")

InfoBlock.create(name: "about_web", title: "about Vezley.net",
  body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")

InfoBlock.create(name: "manifesto", title: "manifesto",
  body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.


Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.


Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")