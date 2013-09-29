Feature: Data model makes sense
  As Nick
  I want to know that my data model makes sense
  So I don't feel like a chump

  Background:
    Given The store exists
    And A seller named "Nick"
    And A seller named "Will"

  Scenario: Nick and Will trade
    When "Nick" trades for $100 worth of cards for $62.50 of his cards
    When "Will" trades for $100 worth of cards for $62.50 of his cards
    Then The contributions should be
      | Store | $0     |
      | Nick  | $62.50 |
      | Will  | $62.50 |

  Scenario: Nick and Will trade and the store buys
    When "Nick" trades for $100 worth of cards for $62.50 of his cards
    And  "Will" trades for $100 worth of cards for $62.50 of his cards
    And  The store buys $100 worth of cards for $50
    Then The contributions should be
      | Nick  | $62.50 |
      | Will  | $62.50 |
      | Store | $50    |

  Scenario: Nick and Will trade and the store buys
    When "Nick" trades for $100 worth of cards for $62.50 of his cards
    And  "Will" trades for $100 worth of cards for $62.50 of his cards
    And  The store buys $100 worth of cards for $50
    And  The store sells $150 worth of cards
    Then The contributions should be
      | Nick  | $62.50 |
      | Will  | $62.50 |
      | Store | $50    |
    And The cash profit is $100
    And The profit is distributed
      | Nick  | $35.71 |
      | Will  | $35.71 |
      | Store | $28.57 |

  Scenario: Nick and Will trade and the store buys
    When "Nick" trades for $1000 worth of cards for $625 of his cards
    And  "Will" trades for $100 worth of cards for $62.50 of his cards
    And  The store buys $100 worth of cards for $50
    And  The store sells $150 worth of cards
    Then The contributions should be
      | Nick  | $625   |
      | Will  | $62.50 |
      | Store | $50    |
    And The cash profit is $100
    And The profit is distributed
      | Nick  | $84.75 |
      | Will  | $ 8.47 |
      | Store | $ 6.78 |

  @javascript
  Scenario: Entering Data
    When I go to the selling page
    When "Nick" sells $20
    Then the total sold should be $20
    When "Will" sells $30
    Then the total sold should be $50

    When "Nick" trades $10
    Then the total traded should be $10
    When "Will" trades $20
    Then the total traded should be $30

    When "Store" buys $13
    Then the total bought should be $13
