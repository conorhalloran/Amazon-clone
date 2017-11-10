# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
Category.destroy_all
Review.destroy_all
User.destroy_all
Tag.destroy_all

PASSWORD = 'password'

super_user = User.create(
    first_name: 'Jon',
    last_name: 'Snow',
    email: 'js@winterfell.gov',
    password: PASSWORD,
    api_key: SecureRandom.urlsafe_base64(64)

  )

10.times.each do
first_name = Faker::Name.first_name
last_name = Faker::Name.last_name
User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD,
    api_key: SecureRandom.urlsafe_base64(64)
)
end

users = User.all

20.times.each do
    Category.create(
        name: Faker::Vehicle.manufacture
    )
end

categories = Category.all

30.times do 
    Tag.create(name: Faker::Space.galaxy)
end

tags = Tag.all

1000.times.each do
    Product.create(
        title: Faker::FunnyName.three_word_name, 
        description: Faker::MostInterestingManInTheWorld.quote,
        price: rand(1...1000),
        category: categories.sample,
        user: users.sample
    )
end

products = Product.all

products.each do |product|
    rand(0..5).times.each do
        Review.create(
            body: Faker::Company.catch_phrase,
            rating: rand(1..5),
            product_id: product[:id],
            user: users.sample,
            likers: users.shuffle.slice(0..rand(10))
        )
    end
    product.favourited_users = users.shuffle.slice(0..rand(10))
    product.tags = tags.shuffle.slice(0..rand(5))

end

reviews = Review.all

puts Cowsay.say("Created #{users.count} users", :tux)
puts Cowsay.say("Created #{reviews.count} reviews", :moose)
puts Cowsay.say("Created #{products.count} products", :ghostbusters)
puts Cowsay.say("Created #{tags.count} tags", :moose)
puts "Login with #{super_user.email} and password of '#{PASSWORD}'"