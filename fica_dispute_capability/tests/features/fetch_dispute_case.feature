@devTest
Feature: Fetch dispute case
    Retrieves details of specific dispute case from the system

  Background:
    Given I log in
    And I start a new conversation

  Scenario: Display error message when dispute case is not found.
    When I say "show dispute case for 24421"
    Then response has 1 messages
    And first message has type text
    And first message content contains "There was no data found for dispute case"

  Scenario: Display dispute details for Missing Credit
    When I say "show dispute case 40000000171"
    Then response has 3 messages
    And first message has type card
    And second message has type text
    Then message at index 2 has button at index <index> with properties:
      | type  | postback |
      | title | <title>  |

    Examples:
      | index | title                          |
      |     0 | A. Review FI-CA open credits   |
      |     1 | B. Review CI open credits      |
      |     2 | C. Review closed dispute cases |
      |     3 | D. Review Contract Accounts    |

  Scenario: Display dispute details for Missing Payment
    When I say "show dispute case for 50000000012"
    Then response has 3 messages
    And first message has type card
    And second message has type text
    Then message at index 2 has button at index <index> with properties:
      | type  | postback |
      | title | <title>  |

    Examples:
      | index | title                                    |
      |     0 | A. Review Contract Accounts for Customer |
      |     1 | B. Review last 3 months FI-CA invoices   |
      |     2 | C. Review last 3 months CI invoices      |

  Scenario: Display dispute details for Incorrect Credit
    When I say "show dispute case for 40000000161"
    Then response has 3 messages
    And first message has type card
    And second message has type text
    Then message at index 2 has button at index <index> with properties:
      | type  | postback |
      | title | <title>  |

    Examples:
      | index | title                          |
      |     0 | A. Review FI-CA open credits   |
      |     1 | B. Review CI open credits      |
      |     2 | C. Review closed dispute cases |
