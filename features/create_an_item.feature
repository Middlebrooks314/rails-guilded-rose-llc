Feature: Test post endpoint
  As an admin
  I want it post an item to the database with valid parameters and return a valid response
  
  Scenario: In order to verify that an item can be added
    Given I create an Item
    And I create another Item
    And I create another Item
    And I create a third Item
    When I request an index of Items
    Then I should see three items
    And each item should have fields name, quality, sell_in
    And the response should have a content type header type of `application/json`