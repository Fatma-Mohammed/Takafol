puts 'Running Case seeder..'

# insert cases of charities
# get charities in batches of 1000, not to get them all and cause memory problems
Charity.take(30).each do |ch|
  (1..10).to_a.sample.times do
    _case = ch.cases.new(
      name: Faker::Name.unique.name,
      job: Faker::Job.position,
      description: Faker::Quote.famous_last_words,
      children_num: Faker::Number.between(from: 0, to: 8),
      marital_status: %w[Married Divorced Single].sample,
      priority: Faker::Number.between(from: 0, to: 5),
      # address: Faker::Address.unique.full_address,
      city_id: Faker::Number.between(from: 1, to: 250),
      phone: Faker::Base.unique.numerify('############'),
      national_id: Faker::Base.unique.numerify('##############')
    )
    saving_result = _case.save(validate: false)
    ch.charities_cases.create(case: _case, state: 'protected') if saving_result and [true, false].sample
  end
end

puts 'Case seeder done successfully..'

