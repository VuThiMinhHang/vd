namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_books
    # make_relationships
  end
end

def make_users
    users = User.create!(name: "vu thi minh hang",
                         email: "vu.thi.minh.hang@framgia.com",
                         password: "123456",
                         password_confirmation: "123456"
                         )
    40.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)

    end
  end


    def make_books
  users = User.all(limit: 10)
  15.times do
    name  = Faker::Name.name
    description = Faker::Lorem.sentence(5)
    users.each { |user| user.books.create!(name: name, description: description) }
  end
end

# def make_relationships
#   users = User.all
#   user  = users.first
#   followed_users = users[2..50]
#   followers      = users[3..40]
#   followed_users.each { |followed| user.follow!(followed) }
#   followers.each      { |follower| follower.follow!(user) }
# end