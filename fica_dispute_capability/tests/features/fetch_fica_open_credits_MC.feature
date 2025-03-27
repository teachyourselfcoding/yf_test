@devTest
Feature: Fetch FI-CA open credits for missing credits
    Retrieves FI-CA open credits details of specific dispute case from the system

  Background:
    Given I log in
    And I start a new conversation
    When I say "show dispute case for 40000000159"

  Scenario: Review FI-CA open credits
    Given I test dialog node with title "A. Review FI-CA open credits"
    When I say "A. Review FI-CA open credits"
    Then response has no disambiguation
    And response has 3 messages
    And first message has type list
    And second message has type buttons
    And third message has type quickReplies
    Then message at index 2 has button at index <index> with properties:
      | title | <title> |
      | value | <value> |

    Examples:
      | index | title                    | value               |
      |     0 | Yes, process the dispute | Resolve the dispute |
      |     1 | No, reject the dispute   | Reject the dispute  |
