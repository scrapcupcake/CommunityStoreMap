def getstore(store)
  @known_stores ||= {  
:knightfall_games => { 
        :lat => 45.48692, 
        :lng => -122.779996, 
        :address => "9955 SW Beaverton-Hillsdale Highway #117, Beaverton, OR, 97005",
        :name => "Knightfall Games", 
        :url => "http://www.knightfallgames.com"},
:guardian_games => {
        :lat => 45.5206514, 
        :lng => -122.6628754, 
        :address => "303 Southeast 3rd Avenue Portland, OR 97214",
        :name => "Guardian Games", 
        :url => "http://www.ggportland.com/"},
:gamealot_games => { 
        :lat => 36.9759537,
        :lng => -122.0261299,
        :address => "835 Front Street Santa Cruz, CA 95060-4510",
        :name => "Game-Alot Toys and Games",
        :url => "http://www.gamealot.com"
        },
:invalid_games => {
          :lat => 0,
          :lng => 0,
          :address => "Nowhere really, trust me",
          :name => "Invalid Games",
          :url => "http://www.example.com"
        }
  }
  storesym = store.sub(" ", "").tableize.to_sym
  Factory.attributes_for(:store, @known_stores[storesym])
end

Given /^I have stores? (.+)$/ do |stores|
  stores.split(", ").each do |store|
    store_details = getstore(store)
    store_details[:approved] = true
    Factory(:store, store_details)
  end
end

Given /^I have unapproved stores? (.+)$/ do |stores|
  stores.split(", ").each do |store|
    store_details = getstore(store)
    store_details[:approved] = false
    Factory(:store, store_details)
  end
end

When /^I add store (.+)$/ do |store|
    store_details = getstore(store)
    When %{I fill in "store_name" with "#{store_details[:name]}"}
    When %{I fill in "store_address" with "#{store_details[:address]}"}
    When %{I fill in "store_url" with "#{store_details[:url]}"}
    When %{I fill in "store_description" with "#{store_details[:description]}"}
    When %{I fill in "store_phone_number" with "#{store_details[:phone_number]}"}
    When %{I fill in "store_email" with "#{store_details[:email]}"}
    When %{I fill in "store_hours" with "#{store_details[:hours]}"}
    store_details[:game_systems].each do |game|
      When %{I check "#{game.name}"}
    end
    When %{I press "Create Store"}
end

Then /^I should see the store summary for "([^"]*)"$/ do |store|
    store_db = Store.find_by_name(store)
    store_db.should be
    store_db.approved.should be_true
    id = store_db.id
    
    Then %{I should see "#{store_db.name}" within the store_id "#{id}"}
    Then %{I should see "#{store_db.phone_number}" within the store_id "#{id}"}
    Then %{I should see "#{store_db.email}" within the store_id "#{id}"}
    Then %{I should see "View Full Details" within the store_id "#{id}"}
    store_db.game_systems.each do |game|
      Then %{I should see "carries #{game.name}" within the store_id "#{id}"}
    end
    Then %{I should not see "#{store_db.description.gsub("\n"," ")}" within the store_id "#{id}"}
    Then %{I should not see "#{store_db.hours.gsub("\n"," ")}" within the store_id "#{id}"}
end

Then /^I should see store summary (.+)$/ do |store|
    store_db = Store.find_by_name(store)
    store_db.should be
    store_db.approved.should be_true
    id = store_db.id
    
    Then %{I should see "#{store_db.name}" within the store_id "#{id}"}
    Then %{I should see "#{store_db.phone_number}" within the store_id "#{id}"}
    Then %{I should see "#{store_db.email}" within the store_id "#{id}"}
    store_db.game_systems.each do |game|
      Then %{I should see "carries #{game.name}" within the store_id "#{id}"}
    end
    Then %{I should see "#{store_db.description.gsub("\n"," ")}" within the store_id "#{id}"}
    Then %{I should see "#{store_db.hours.gsub("\n"," ")}" within the store_id "#{id}"}
end

Then /^I should have the store "([^"]*)" approved$/ do |store|
  Store.approved.where(:name => store).count.should equal 1
end

Then /^I should have the store "([^"]*)" waiting to be approved$/ do |store|
  Store.unapproved.where(:name => store ).count.should equal 1
end

Then /^I should not have the store "([^"]*)"$/ do |store|
  Store.unapproved.where(:name => store ).count.should equal 0
end

When /^I go try to approve store "([^"]*)"$/ do |store_name|
  When %{I go to the approve store page for "#{store_name}"}
end

When /^I try to edit the store "([^"]*)" to "([^"]*)"$/ do |store, new_name|
  When %{I go to the edit store page for "#{store}"}
  When %{I fill in "store_name" with "#{new_name}"}
  When %{I press "Update Store"}
  Then %{I should be on the store page for "#{new_name}"}
  Then %{I should see "#{new_name}"}
  Then %{I should not see "#{store}"}
end

When /^I delete the store "([^"]*)"/ do |store_name|
  store = Store.find_by_name(store_name)
  rack_test_session_wrapper = Capybara.current_session.driver
  rack_test_session_wrapper.process :delete, store_path(store)
end