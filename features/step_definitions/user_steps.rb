Given /^I have no users$/ do
  User.delete_all
end

Then /^I should be able to create a normal user$/ do
  When %{I fill in "user_email" with "test@test.com"}
  When %{I fill in "user_password" with "testtest"}
  When %{I fill in "user_password_confirmation" with "testtest"}
  When %{I press "Create User"}
  Then %{I should have a new user "test@test.com"}
  Then %{User "test@test.com" should have no roles}
end

Then /^I should be able to create a new (.*)$/ do |usertype|
  role = case usertype #yup, I know, I'm doing too much work, doing 'extension' work
  when /admin(istrator)/i
    "Admin"
  end
  
  When %{I fill in "user_email" with "test@test.com"}
  When %{I fill in "user_password" with "testtest"}
  When %{I fill in "user_password_confirmation" with "testtest"}
  When %{I check "#{role}"}
  When %{I press "Create User"}
  Then %{I should have a new user "test@test.com"}  
  Then %{User "test@test.com" should have role #{role}}  
end

Then /^I should have a new user "([^"]*)"$/ do |email|
  User.find_by_email(email).should be
end

Then /^User "([^"]*)" should have role (.*)$/ do |email, role|
    user = User.find_by_email(email)
    user.role?(role.downcase.to_sym).should be_true
end

Then /^User "([^"]*)" should have no roles$/ do |email|
    user = User.find_by_email(email)
    user.should have(0).roles
end

When /^I force create a new user$/ do
  user = Factory.attributes_for(:user)
  rack_test_session_wrapper = Capybara.current_session.driver
  rack_test_session_wrapper.process :post, users_path, :params => user
end