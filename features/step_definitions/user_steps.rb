Given /^I have no users$/ do
  User.delete_all
end

Then /^I should be redirected to the user edit page$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I update the user to be "([^"]*)"$/ do |user|
  pending # express the regexp above with the code you wish you had
end
