require 'faker'

# Destination.destroy_all

address = Faker::Address.city
country = Faker::Address.country

15.times do
  Destination.create(
    city: Faker::Address.city,
    country: Faker::Address.country
  )
end


# traveller1 = Traveller.create(
#   name: "Michelle"
# )

