Feature: View Stores
  In order to have a map with many stores listed
  As a visitor
  I want to view all known stores

  Scenario: View Map
    Given I have stores Knightfall Games, Guardian Games
    When I go to the store map
    Then I should see "Knightfall Games"
    And I should see "Guardian Games"
    
  Scenario: Area Map
    Given I have stores Knightfall Games, Guardian Games, Gamealot Games
    When I go to the store map
    Then I should see "Knightfall Games" 
    And I should see "Guardian Games"
    And I should see "Game-Alot Toys and Games"
    When I fill in "store_search_near" with "Portland, OR"
    And I press "Search For Stores Near"
    Then I should see "Knightfall Games" 
    And I should see "Guardian Games"
    And I should not see "Game-Alot Toys and Games"
    
  Scenario: View Map As Admin
    Given I have stores Knightfall Games, Guardian Games
    And I am an administrator
    When I go to the store map
    Then I should see "Knightfall Games"
    And I should see "Guardian Games"
    
  Scenario: Area Map As Admin
    Given I have stores Knightfall Games, Guardian Games, Gamealot Games
    And I am an administrator
    When I go to the store map
    Then I should see "Knightfall Games" 
    And I should see "Guardian Games"
    And I should see "Game-Alot Toys and Games"
    When I fill in "store_search_near" with "Portland, OR"
    And I press "Search For Stores Near"
    Then I should see "Knightfall Games" 
    And I should see "Guardian Games"
    And I should not see "Game-Alot Toys and Games"