@devTest
Feature: Fetch closed dispute case for Missing credits.
    Retrieves closed dispute case details of specific dispute case from the system

  Background:
    Given I log in
    And I start a new conversation
    When I say "show dispute case for 40000000159"

  Scenario: Review closed dispute case
    Given I test dialog node with title "C. Review closed dispute cases"
    When I say "C. Review closed dispute cases"
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
