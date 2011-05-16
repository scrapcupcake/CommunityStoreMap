Feature: Add Users
This site should be locked down to admins for now, as the core functionality 
is adding stores to the map, and only admins need to be able to approve maps and
add other admins. The app has a default user created via seed.

  Scenario: Admin can create another admin
  Given I am an administrator
  When I go to the new user page
  Then I should be able to create a new administrator
  
  Scenario: Admin can create a normal user
  Given I am an administrator
  When I go to the new user page
  Then I should be able to create a normal user
  
  Scenario: Normal user cannot create a new user
  Given I am a new, authenticated user
  When I go to the new user page
  Then I should have access denied
  When I force create a new user
  Then I should have access denied
  
  Scenario: Guest cannot create a new user
  When I go to the new user page
  Then I should have access denied
  When I force create a new user
  Then I should have access denied