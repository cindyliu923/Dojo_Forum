namespace :dev do

  task fake_user: :environment do
    User.destroy_all
    url = "https://uinames.com/api/?ext&region=england"

    10.times do
      response = RestClient.get(url)
      data = JSON.parse(response.body)

      user = User.create!(
        name: data["name"],
        email: data["email"],
        remote_avatar_url: data["photo"],
        password: "12345678",
        introduction: "Hi! My name is #{data["name"]} #{FFaker::DizzleIpsum::paragraph(10)}"
      )
    end

    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end

  task fake_post: :environment do
    Post.destroy_all
    User.all.each do |user|   
      5.times do |i|
        permit = ["all","friend","myself"]
        user.posts.create!(
          title: FFaker::Movie.title,
          description: FFaker::Lorem.sentence(50),
          status: "publish",
          permit: permit.sample,
      )
      end
    end

    Post.all.each do |post|
      3.times do |i|
        CategoryOfPost.create!(category: Category.all.sample, post: post)
      end
    end

    puts "have created fake posts"
    puts "now you have #{Post.count} post data"
  end

end