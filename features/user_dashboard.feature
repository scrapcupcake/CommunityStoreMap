Feature: User's Dashboard
Users should see links at the top of the page when they are signed in, based on their rights to 
manage and modify various things on the site. For example, a user should be able to edit their own 
profile. A user administrator should be able to create, edit and delete other users. A store administrator should 
be able to see a link to manage the current stores and another to approve stores pending approval.
  
  Scenario: Even guests can see the Store Map link
  When I go to the home page
  Then I should be able to see and visit the "Store Map" page

  Scenario: Store administrator Can Use Manage Stores Link
  Given I am an administrator
  When I go to the home page
  Then I should be able to see and visit the "Manage Stores" page
  
  Scenario: Store administrator Can Use Store Approval Link
  Given I am an administrator
  And I have unapproved stores Knightfall Games, Guardian Games
  When I go to the home page
  Then I should be able to see and visit the "Stores Pending Approval(2)" link
  
  Scenario: User administrator Can Use Manage Users Link
  Given I am an administrator
  When I go to the home page
  Then I should be able to see and visit the "Manage Users" link

  Scenario: Normal User Can't Use Store Approval Link
  Given I am a new, authenticated user
  When I go to the home page
  Then I should not see "Stores Pending Approval"
  
  Scenario: Normal User Can't Use Manage Users Link
  Given I am a new, authenticated user
  When I go to the home page
  Then I should not see "Manage Users"
  
  Scenario: Normal User Can Use Edit Profile Link
  Given I am a new, authenticated user with email "eddie@example.org"
  When I go to the home page
  Then I should be able to see and visit the "Edit Profile" link for user "eddie@example.org"