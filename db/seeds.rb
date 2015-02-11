99.times do |n|
  name  = Faker::Name.name
  desc = Faker::Lorem.sentence(5)
  Course.create!(name: name,description: desc)
end

User.create!(name:  "Hien Tran",
  email: "hientv@example.com",
  address: "Tran Phu - Ha Dong",
  date_of_join: "Fri, 19 Sep 2014",
  password: "1234567",
  password_confirmation: "1234567",
  is_supervisor: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  address = Faker::Address.street_address
  date_of_join = Faker::Date.backward(14)
  password = "1234567"
  User.create!(name:  name,
    email: email,
    address: address,
    date_of_join: date_of_join,
    password: password,
    password_confirmation: password)
end