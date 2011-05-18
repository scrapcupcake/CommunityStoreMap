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

Then /^I can edit user "([^"]*)" to "([^"]*)"$/ do |original_email, new_email|
  When %{I go to the edit profile page for "#{original_email}"}
  When %{I fill in "user_email" with "#{new_email}"}
  When %{I press "Update User"}
  Then %{I should be on the user page for "#{new_email}"}
  Then %{I should see "#{new_email}"}
  Then %{I should not see "#{original_email}"}
end

Then /^I can change the password for "([^"]*)" from "([^"]*)" to "([^"]*)"$/ do |email, old_password, new_password|
  When %{I go to the edit profile page for "#{email}"}
  When %{I fill in "user_current_password" with "#{old_password}"}
  When %{I fill in "user_password" with "#{new_password}"}
  When %{I fill in "user_password_confirmation" with "#{new_password}"}
  When %{I press "Update User"}
  Then %{I should see "User was successfully updated."}
  When %{I go to login}
  When %{I fill in "user_email" with "#{email}"}
  When %{I fill in "user_password" with "#{new_password}"}
  When %{I press "Sign in"}
  Then %{I should be on the home page}
  Then %{I should see "Signed in successfully."}
end

Then /^I can delete "([^"]*)"$/ do |email|
  When %{I go to the manage users page}
  Then %{I should see "#{email}"}
  When %{I follow "Delete" within the user "#{email}"}
  Then %{I should not see "#{email}"}
  When %{I go to the manage users page}
  Then %{I should not see "#{email}"}
end

Then /^I cannot delete the account "([^"]*)"$/ do |email|
  When %{I go to the manage users page}
  Then %{I should not see "Delete" within the user "#{email}"}
  When %{I force delete user "#{email}"}
  Then %{I should have access denied}
end


Given /^I have a normal user "([^"]*)"$/ do |email|
  Factory(:user, :email => email )
end

Given /^I have an administrator "([^"]*)"$/ do |email|
  Factory(:user, :email => email, :roles => [Role.find_by_name("Admin")])
end

When /^I force delete user "([^"]*)"$/ do |email|
  user = User.find_by_email(email)
  rack_test_session_wrapper = Capybara.current_session.driver
  rack_test_session_wrapper.process :delete, user_path(user)
end

When /^I force edit user "([^"]*)"$/ do |email|
  user = User.find_by_email(email)
  user.email = "haxlol@example.com"
  rack_test_session_wrapper = Capybara.current_session.driver
  rack_test_session_wrapper.process :put, user_path(user) #has to be put to update when in test
  #:post means new user, except from web browsers :/
end

When /^I force create a new user$/ do
  user = Factory.attributes_for(:user)
  rack_test_session_wrapper = Capybara.current_session.driver
  rack_test_session_wrapper.process :post, users_path, :params => user
end