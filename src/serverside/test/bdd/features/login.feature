Feature: Login


###############
# Sunny Cases #
###############


  Scenario: Successful log in
      Given I have the following login details:
      |       email       | user_password |
      | kristel@gmail.com |      asd      |
      When I click login button
      Then I get a '200' response
      And a message "Successfully Logged In" is returned