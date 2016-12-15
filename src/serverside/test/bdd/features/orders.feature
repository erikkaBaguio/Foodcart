Feature: Order


###############
# Sunny Cases #
###############


  Scenario: Adding Order
      Given I have the following order details:
      | user_id | quantity | food_id | resto_branch_id |
      |    4    |     1    |    4    |        2        |
      When the user clicks the add button
      Then  it should have a '200' response
      And   it should have a field 'status' containing 'OK'
      And   it should have a field 'message' containing 'OK'