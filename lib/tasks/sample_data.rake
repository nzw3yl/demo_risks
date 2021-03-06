require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(:name => "Example User",
                       :email => "example@railstutorial.org",
                       :password => "foobar",
                       :password_confirmation => "foobar",
                       :alias => "foobar")
  admin.toggle!(:admin)
  admin.toggle!(:manager)
  manager = User.create!(:name => "Example Manager",
                       :email => "manager@railstutorial.org",
                       :password => "foobar",
                       :password_confirmation => "foobar",
                       :alias => "manager")
  manager.toggle!(:manager)
  20.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    aliasname = "boo#{n+1}"
    password  = "password"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password,
                 :alias => aliasname)
  end
end

def make_microposts
  User.all(:limit => 6).each do |user|
    20.times do
      content = Faker::Lorem.sentence(5)
      user.microposts.create!(:content => content)
    end
  end
end

def make_relationships
  users = User.all
  user  = users.first
  following = users[1..20]
  followers = users[3..15]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end

