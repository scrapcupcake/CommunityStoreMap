Feature: Manage Stores
Admins should be able to manage the stores, normal users and guests should not.

  Scenario: Store admin can edit a store
  Given I am an administrator
  And I have store Knightfall Games
  When I try to edit the store "Knightfall Games" to "Someother Games"
  Then I should see "Someother Games"
  
  Scenario: Store admin can edit unapproved existing store
  Given I am an administrator
  And I have unapproved store Knightfall Games
  When I try to edit the store "Knightfall Games" to "Someother Games"
  Then I should see "Someother Games"  
  
  Scenario: Store admin can delete a store
  Given I am an administrator
  And I have unapproved store Knightfall Games
  When I go to the manage stores page
  And I follow "Delete" 
  #consider javascripting this, testing for prompt
  Then I should not see "Knightfall Games"
  
  Scenario: Normal user cannot edit stores
  Given I am a new, authenticated user
  And I have store Knightfall Games
  When I go to the edit store page for "Knightfall Games"
  Then I should have access denied
  And I should see "Knightfall Games"
  
  @rack-test
  Scenario: Normal user cannot delete stores
  Given I am a new, authenticated user
  And I have store Knightfall Games
  When I delete the store "Knightfall Games"
  Then I should have access denied
  And I should see "Knightfall Games"
  
  Scenario: Guest cannot edit stores
  Given I have store Knightfall Games
  When I go to the edit store page for "Knightfall Games"
  Then I should have access denied
  And I should see "Knightfall Games"
  
  @rack-test
  Scenario: Guest cannot delete stores
  Given I have store Knightfall Games
  When I delete the store "Knightfall Games"
  Then I should have access denied
  And I should see "Knightfall Games"