Given /^I have no users$/ do
  User.delete_all
end

Then /^I should be able to see and visit the "([^"]*)" link$/ do |link|
  Then %{I should see "#{link}"}
  When %{I follow "#{link}"}
  Then %{I should be on "#{link.downcase}"} #all things used as link should be in the path file
end

Then /^I should be able to see and visit the "([^"]*)" link for user "([^"]*)"$/ do |link, email|
  Then %{I should see "#{link}"}
  When %{I follow "#{link}"}
  Then %{I should be on the #{link} page for "#{email}"} #all things used as link should be in the path file
  Then %{I should see "#{email}"}
end
