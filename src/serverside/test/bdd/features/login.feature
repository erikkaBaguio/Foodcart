Feature: Login


###############
# Sunny Cases #
###############


  Scenario: Successful log in
      Given I have the following login details:
      |      email_add  | password |
      | minho@gmail.com |    asd   |
      When I click login button
      Then I get a '200' response
#      And a message "Successfully Logged In" is returned
      And   it should have a field 'status' containing 'OK'
      And   it should have a field 'message' containing 'Successfully logged in'




###############
# Rainy Cases #
###############

  Scenario: Empty email field
        Given I have the following login details:
              |email_add      |password  |
              |               |asdasd    |
        When I click login button
        Then I get a '200' response
        And a message "Invalid email or password" is returned


  Scenario: Empty password field
        Given I have the following login details:
              |  email_add      |password  |
              | james@gmail.com |          |
        When I click login button
        Then I get a '200' response
        And a message "Invalid email or password" is returned
