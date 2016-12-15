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
