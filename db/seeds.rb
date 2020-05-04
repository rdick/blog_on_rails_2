
Comment.delete_all
Post.delete_all

NUM_COMMENTS = 3
NUM_POSTS = 50

NUM_POSTS.times do
    created_at = Faker::Date.backward(days: 365)
    p = Post.create(
        title: Faker::Games::HalfLife.enemy,
        body: Faker::Lorem.paragraph
    )
    NUM_COMMENTS.times do
        Comment.create(
            body: Faker::Superhero.name,
            post_id: p.id
        )
    end
end

puts "generated #{Post.all.count} posts"
puts "generated #{Comment.all.count} posts"