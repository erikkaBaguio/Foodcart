Feature: Order


###############
# Sunny Cases #
###############


  Scenario: Adding Order
      Given I have the following order details:
      | role_id | payment_id | order_foods_id |
      |    3    |      1     |        1       |
      When the user clicks the add button
      Then  it should have a '200' response
      And   it should have a field 'status' containing 'OK'
      And   it should have a field 'message' containing 'OK'