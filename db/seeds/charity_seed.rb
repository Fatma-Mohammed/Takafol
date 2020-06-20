puts 'Running charity seeder..'

50.times do
  Charity.create(
    email: Faker::Internet.unique.email,
    password: '123123',
    name: Faker::Restaurant.unique.name,
    address: Faker::Address.unique.full_address,
    phone_number: Faker::PhoneNumber.unique.cell_phone_with_country_code,
    description: Faker::Restaurant.description,
    city_id: Faker::Number.between(from: 1, to: 250),
  ).save(validate: false)
end
puts 'Charity seeder done successfully..\n\n'
