known_stores ||= {  
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

Given /^I have stores? (.+)$/ do |stores|
  stores.split(", ").each do |store|
    storesym = store.sub(" ", "").tableize.to_sym
    store_details = known_stores[storesym]
    store_details["description"] = "Test"
    Factory(:store, store_details)
  end
end

When /^I add store (.+)$/ do |store|
    storesym = store.sub(" ", "").tableize.to_sym
    store_details = known_stores[storesym]
    store_details[:description] ||= "Test"
    When %{I fill in "store_name" with "#{store_details[:name]}"}
    When %{I fill in "store_address" with "#{store_details[:address]}"}
    When %{I fill in "store_url" with "#{store_details[:url]}"}
    When %{I fill in "store_description" with "#{store_details[:description]}"}
    When %{I press "Create Store"}
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