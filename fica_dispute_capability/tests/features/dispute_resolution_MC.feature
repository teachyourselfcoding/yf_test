@devTest
Feature: Dispute resolution for missing credits.
    Retrieves options which can help in resolving dispute for missing credits.

  Background:
    Given I log in
    And I start a new conversation

  Scenario: Fetch option for dispute resolution
    When I say "show dispute case for 40000000159"
    Then response has 3 messages
    When I say "A. Review FI-CA open credits"
    Then response has 3 messages
    When I say "Yes, process the dispute"
    Then response has no disambiguation
    And response has 1 messages
    And first message has type buttons
