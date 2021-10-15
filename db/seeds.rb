# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create!(email: 'manager1@mail.com', password: '123456', password_confirmation: '123456', name: 'manager 1')
user1.create_team(name: 'team1', description: 'desc')

user2 = User.create!(email: 'manager2@mail.com', password: '654321', password_confirmation: '654321', name: 'manager 1')
user2.create_team(name: 'team2', description: 'desc')
