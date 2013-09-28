# Completing Sales from Start to Finish
Scenario: A Basic Sale
  Given Nick is a Seller
  When a customer wants to by $30 of Nick's Cards
  Then I am able to process a sale

Scenario: A complicated transaction
  Given Nick, Jon and the Store are all Sellers
  When a customer wants to complete the following transaction:
    | Nick  | sells   | $20
    | Jon   | trades  | $40
    | Store | buys    | $60
  Then I am able to process a sale

#How the interface should display data being put into it
Scenario: Displaying Totals
  Given Nick and Jon are Sellers
  When a seller wants to enter in the following transaction:
    | Nick  | sells   | $20
    | Jon   | sells   | $40
  Then the total of the sales section is $60

Scenario: Displaying different transactions
  Given Nick, Jon and the Store are all Sellers
  When a customer wants to complete the following transaction:
    | Nick  | sells   | $20
    | Nick  | trades  | $30
    | Jon   | trades  | $40
    | Jon   | sells   | $50
    | Store | sells   | $60
    | Store | buys    | $80
  Then the total of each section is:
    | Sales   | $130
    | Trades  | $70
    | Buys    | $80
