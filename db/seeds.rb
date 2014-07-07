require 'faker'
Wiki.destroy_all
Plan.destroy_all
# Create Wikis
50.times do
  Wiki.create(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
    )  
end

wikis = Wiki.all

Plan.create(name: 'basic', price: 0.00)
Plan.create(name: 'Premium', price: 2.99)

puts "Seed finished"
puts "#{Wiki.count} wikis created"