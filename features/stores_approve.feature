Feature: Approve Stores

  Scenario: Admin can view pending stores
  Given I am an administrator
  And I have unapproved stores Knightfall Games, Guardian Games
  When I go to the home page
  Then I should be able to see and visit the "Stores Pending Approval(2)" link
  And I should see "Knightfall Games"
  And I should see "Guardian Games"
  And I should see "Approve"
  And I should see "Delete"
  And I should see "Edit"
  
  Scenario: Admin can approve pending store
  Given I am an administrator
  And I have unapproved store Knightfall Games
  When I go to the stores pending approval
  Then I should see "Knightfall Games"
  When I follow "Approve"
  Then I should be on stores pending approval
  And I should not see "Knightfall Games"
  When I go to the home page
  Then I should see "Knightfall Games"

  Scenario: Normal user cannot view pending stores
  Given I am a new, authenticated user
  When I go to the stores pending approval
  Then I should have access denied
  
  Scenario: Normal user cannot approve pending store
  Given I am a new, authenticated user
  And I have unapproved store Knightfall Games
  When I go try to approve store "Knightfall Games"
  Then I should have access denied
  
  Scenario: Guest cannot view pending stores
  When I go to the stores pending approval
  Then I should have access denied
  
  Scenario: Guest cannot approve pending store
  Given I have unapproved store Knightfall Games
  When I go try to approve store "Knightfall Games"
  Then I should have access denied