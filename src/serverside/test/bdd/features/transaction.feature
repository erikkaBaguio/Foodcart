Feature: Transaction


###############
# Sunny Cases #
###############


  Scenario: Adding Transaction
      Given I have the following transaction details:
      | transaction_number | order_id | total | bldg_number | street | room_number |
      |          1         |     3    |   4   |      2      |  test  |      8      |
      When the user clicks the add button for transaction
      Then  it should have a '200' response
      And   it should have a field 'status' containing 'OK'
      And   it should have a field 'message' containing 'OK'


  Scenario: Retrieve specific transaction
      Given the transaction with an id '5'
      When  view button for transaction is clicked
      Then  it should have a '200' response
      And   the following details will be returned:
      | transaction_number |      transaction_date      | order_id | total | bldg_number |    street   | room_number | is_paid |
      |          1         | 2016-12-17 08:48:58.122318 |     1    |   4   |      2      |     test    |      8      |  FALSE  |


###############
# Rainy Cases #
###############


  Scenario: View Specific Transaction - id does not exist
            Given the transaction with an id '100'
            When  view button for transaction is clicked
            Then  it should have a '200' response
