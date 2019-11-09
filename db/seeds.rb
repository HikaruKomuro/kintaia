# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(name: "管理者",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true,
             superior: 1)

2.times do |n|
  name  = Faker::Name.name
  email = "sample#{n+1}@email.com"
  password = "password"
  employee_number = "#{(n+1)*111}"
  uid = "abc#{(n+1)*111}"
  User.create!(name: name,
               email: email,
               superior: 1,
               affiliation: "営業",
               employee_number: employee_number,
               uid: uid,
               password: password,
               password_confirmation: password)
end

2.times do |n|
  name  = "上長#{n+1}"
  email = "sample#{n+10}@email.com"
  password = "password"
  employee_number = "#{(n+1)*1111}"
  uid = "def#{(n+1)*1111}"
  User.create!(name: name,
               email: email,
               superior: 2,
               affiliation: "営業",
               employee_number: employee_number,
               uid: uid,
               password: password,
               password_confirmation: password)
end