Then /^I should be able to see and visit the "([^"]*)" (link|page)$/ do |link, unused|
  Then %{I should see "#{link}"}
  When %{I follow "#{link}"}
  Then %{I should be on the #{link} page} #all things used as link should be in the path file
end

Then /^I should be able to see and visit the "([^"]*)" link for user "([^"]*)"$/ do |link, email|
  Then %{I should see "#{link}"}
  When %{I follow "#{link}"}
  Then %{I should be on the #{link} page for "#{email}"} #all things used as link should be in the path file
  Then %{I should see "#{email}"}
end