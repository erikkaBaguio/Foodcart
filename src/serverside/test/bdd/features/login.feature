Feature: Login


###############
# Sunny Cases #
###############


  Scenario: Successful log in
      Given I have the following login details:
      |      email      | password |
      | james@gmail.com |  asdasd  |
      When I click login button
      Then I get a '200' response
      And a message "Successfully Logged In" is returned


###############
# Rainy Cases #
###############

  Scenario: Empty email field
        Given I have the following login details:
              |email          |password  |
              |               |asdasd    |
        When I click login button
        Then I get a '200' response
        And a message "Invalid email or password" is returned


  Scenario: Empty password field
        Given I have the following login details:
              |  email          |password  |
              | james@gmail.com |          |
        When I click login button
        Then I get a '200' response
        And a message "Invalid email or password" is returned