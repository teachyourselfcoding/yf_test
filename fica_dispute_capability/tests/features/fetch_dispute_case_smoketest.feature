@smokeTest
Feature: Fetch dispute case
    Retrieves details of specific dispute case from the system

  Background:
    Given I log in
    And I start a new conversation

  Scenario: Show Dispute Case
    When I say "show dispute case"
    Then response has 1 message
    And first message has type text
