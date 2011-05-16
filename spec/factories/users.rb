Factory.define :user do |f|
  f.sequence(:email) { |n| "test#{n}@example.com" }
  f.password "TestTest"
  f.password_confirmation "TestTest"
  f.roles []
end