puts 'Running donor seeder..'

25.times do
  Donor.create(
    email: Faker::Internet.unique.email,
    password: '123123',
    name: Faker::Name.unique.name,
    national_id: Faker::Base.unique.numerify('##############'),
    # national_id_img:
    address: Faker::Address.unique.full_address,
    # phone_number: Faker::PhoneNumber.unique.cell_phone_with_country_code
  ).save(validate: false)
end
puts 'Donor seeder done successfully..\n\n'

