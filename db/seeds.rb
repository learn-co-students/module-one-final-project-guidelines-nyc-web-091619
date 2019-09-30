require 'faker'

address = Faker::Address.city
country = Faker::Address.country

50.times do
  Destination.create(
    city: Faker::Address.city,
    country: Faker::Address.country
  )
end
