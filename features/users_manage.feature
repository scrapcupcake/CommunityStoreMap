
Feature: User Management
Admins should be able to edit/delete anybody, except can't delete themselves, 
so you can't lock the system entirely.
Normal users should be able to edit only themselves, no deleting. 
Guests should be able to edit and delete NOTHING, mwahahaha.

  Scenario: Administrator can edit another user
  Given I have a normal user "eddie@example.com"
  And I am an administrator
  Then I can edit user "eddie@example.com" to "dilbert@example.com"

  Scenario: Administrator can delete a normal user
  Given I have a normal user "eddie@example.com"
  And I am an administrator
  Then I can delete "eddie@example.com"
  
  Scenario: Administrator can delete another administrator
  Given I have an administrator "adam@example.com"
  And I am an administrator
  Then I can delete "adam@example.com"
  
  Scenario: Administrator cannot delete their own account
  Given I am an administrator with email "adam@example.com"
  Then I cannot delete the account "adam@example.com"

  Scenario: Normal user can edit themselves
  Given I am a new, authenticated user with email "eddie@example.com" and password "ThisPasswordSux!"
  Then I can edit user "eddie@example.com" to "dilbert@example.com"
  And I can change the password for "dilbert@example.com" from "ThisPasswordSux!" to "ThisPasswordR0X!"
  
  Scenario: Normal user cannot edit another user
  Given I am a new, authenticated user
  And I have a normal user "adam@example.com"
  When I go to the edit profile page for "adam@example.com"
  Then I should have access denied
  When I force edit user "adam@example.com"
  Then I should have access denied

  Scenario: Normal user cannot delete themselves
  Given I am a new, authenticated user with email "eddie@example.com"
  When I force delete user "eddie@example.com"
  Then I should have access denied

  Scenario: Normal user cannot delete another user
  Given I have a normal user "adam@example.com"
  And I am a new, authenticated user
  When I force delete user "adam@example.com"
  Then I should have access denied
  
  Scenario: Guest cannot edit anyone
  Given I have a normal user "adam@example.com"
  When I go to the edit profile page for "adam@example.com"
  Then I should have access denied
  When I force edit user "adam@example.com"
  Then I should have access denied
  
  Scenario: Guest cannot delete anyone
  Given I have a normal user "adam@example.com"
  When I force delete user "adam@example.com"
  Then I should have access denied 