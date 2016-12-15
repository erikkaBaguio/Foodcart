Feature: Transaction


###############
# Sunny Cases #
###############


  Scenario: Adding Transaction
      Given I have the following transaction details:
      | transaction_number | order_id | total | bldg_number | street | room_number |
      |          2         |     1    |   4   |      2      |  test  |      8      |
      When the user clicks the add button for transaction
      Then  it should have a '200' response
      And   it should have a field 'status' containing 'OK'
      And   it should have a field 'message' containing 'OK'


  Scenario: Retrieve specific transaction
      Given the transaction with an id '5'
      When  view button for transaction is clicked
      Then  it should have a '200' response
      And   it should have a field 'status' containing 'OK'
      And   it should have a field 'message' containing 'OK'
      And   the following details will be returned:
      | transaction_number |      transaction_date      | order_id | total | bldg_number |    street   | room_number | is_paid |
      |          1         | 2016-12-16 06:08:01.512638 |     1    | 12.5  |     63      | test street |      2      |  FALSE  |