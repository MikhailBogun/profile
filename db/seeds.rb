# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'ffaker'

render = ['other', 'male', 'female']
users_id = User.all().select('id')
# User.create!(email: 'admin@gmail.com', password: 'password', username: FFaker::Name.first_name, isAdmin: true)

User.create!(email: FFaker::Internet.email, password: 'password', username: FFaker::Name.first_name, isAdmin: false)
8.times do
  Profile.create!(
    name: FFaker::Name.first_name,
    gender: render.sample,
    city: FFaker::Address.city,
    birthdate: FFaker::Time.date,
    user_id: users_id.sample[:id]
  )
end
