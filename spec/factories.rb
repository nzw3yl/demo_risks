Factory.define :user do |user|
  user.name			"Roger Smith"
  user.email			"roger.smith@example.com"
  user.password			"foobar"
  user.password_confirmation 	"foobar"
  user.alias			"foobarXX"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.sequence :alias do |n|
  "boo#{n}"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end

Factory.define :contract do |contract|
  contract.alias       "qwerty"
  contract.name        "qwerty"
  contract.description "qwerty"
end

