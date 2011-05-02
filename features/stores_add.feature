Feature: Add Stores
  In order to recommend stores I want to promote
  As a visitor
  I want to be able to add a store to be considered to be added to the map
  

  Scenario: Add New Store
  When I go to the new store page
  And I add store Knightfall Games
  Then I should see "Store was successfully created"
  When I follow "Back"
  Then I should see "Knightfall Games"


  Scenario: Add Existing Store
  Given I have store Knightfall Games
  When I go to the new store page
  And I add store Knightfall Games
  Then I should see "Address must be a unique location"
  When I follow "Back"
  Then I should see "Knightfall Games"
  

  Scenario: Add Invalid Address Store
  When I go to the new store page
  And I add store Invalid Games
  Then I should see "Unable to find address, please verify that it is correct and can be found on google maps"
  When I add store Knightfall Games
  Then I should see "Store was successfully created"
  When I follow "Back"
  Then I should see "Knightfall Games"
  