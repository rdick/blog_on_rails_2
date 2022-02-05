

Comment.delete_all
Post.delete_all
User.delete_all

NUM_COMMENTS = 3
NUM_POSTS = 50
NUM_USER = 10

PASSWORD = '1234'


super_user = User.create(
    name: 'ryan',
    email: 'rdick@ualberta.ca',
    password: PASSWORD,
    is_admin: true
)

non_user = User.create(
    name: 'ryan',
    email: 'rdick@ualbert.ca',
    password: PASSWORD
)

NUM_USER.times do
    User.create(
        name: Faker::Name.first_name,
        email: Faker::Internet.email,
        password: PASSWORD
    )
end

users = User.all

100.times do
    created_at = Faker::Date.backward(days: 365)
    p = Post.create(
        title: Faker::Games::HalfLife.enemy,
        body: Faker::Lorem.paragraph,
        user: users.sample
    )
    if p.valid?
        2.times do
            Comment.create(
                body: Faker::Superhero.name,
                post: p,
                user: users.sample
            )
        end
    end
end

puts "generated #{Post.all.count} posts"
puts "generated #{Comment.all.count} comments"
puts "generated #{User.all.count} users"