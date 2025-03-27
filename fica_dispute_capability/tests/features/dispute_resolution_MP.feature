@devTest
Feature: Dispute resolution for missing credits.
    Retrieves options which can help in resolving dispute for missing credits.

  Background:
    Given I log in
    And I start a new conversation
    And I say "show dispute case for 50000000012"
    When I say "A. Review Contract Accounts for Customer"

  Scenario: Fetch option for dispute resolution
    Given I test dialog node with title "Is the dispute correct?"
    When I say "Yes, process the dispute"
    Then response has no disambiguation
    And response has 1 messages
    And first message has type buttons
