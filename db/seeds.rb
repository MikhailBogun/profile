# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'ffaker'
User.create!(email: FFaker::Internet.email, password: 'password', username: FFaker::Name.first_name, isAdmin: true)
8.times do
  Section.create!(
    name: FFaker::Name.first_name,
    gender: FFaker::Gender,
    city: FFaker::Address.city,
    birthdate: FFaker::Time.date,
    user_id: 1
  )
end
