Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I have one\s+user "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  User.new(:email => email,
           :password => password,
           :password_confirmation => password).save!
end

Given /^I am a new, authenticated user$/ do
  Given %{I am a new, authenticated user with email "testnoname@example.com"}
end

Given /^I am a new, authenticated user with email "([^"]*)"$/ do |email|
  Given %{I am a new, authenticated user with email "#{email}" and password "secretpass"}
end

Given /^I am a new, authenticated user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  Given %{I have one user "#{email}" with password "#{password}"}
  And %{I go to login}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
  Then %{I should see "Signed in as #{email}"}
  And %{I should see "Sign out"}
end

When /^I log in with user "([^\"]*)" with password "([^\"]*)"$/ do |user, password|

  Given %{I have one user "#{email}" with password "#{password}"}
  And %{I go to login}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
  Then %{I should see "Signed in as #{email}"}
  And %{I should see "Sign out"}
end

Given /^I am an administrator$/ do
  Given %{I am an administrator with email "testing@man.net"}
end

Given /^I am an administrator with email "([^"]*)"$/ do |email|
  password = 'secretpass'
  
  Given %{I have one user "#{email}" with password "#{password}"}
  And %{I go to login}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
  Then %{I should see "Signed in as #{email}"}
  And %{I should see "Sign out"}
  
  admin = User.find_by_email(email)
  Role.create_role(:admin)
  admin.grant_role(:admin)
end

Then /^I should have access denied$/ do
  Then %{I should be on the home page}
  Then %{I should see "You are not authorized to access this page."}
end