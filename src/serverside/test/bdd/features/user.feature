Feature: Store User

###############
# Sunny Cases #
###############

	Scenario: Adding user
			Given I have the following user details:
			| fname   | mname |    lname   |  address |            email            | mobile_number | user_password | role_id | earned_points |
			| Kristel |   D   | Pabillaran | Dalipuga | kristelahlainegem@gmail.com |  09123456789  |      asd      |    1    |       0       |
			When I click the register button
			Then I will get a '200' response
			And it should have a field "message" containing "OK"


###############
# Rainy Cases #
###############

    Scenario: Add user - fname field empty
            Given I have the following user details:
			| fname   | mname |    lname   |  address |            email            | mobile_number | user_password | role_id | earned_points |
			|         |   D   | Pabillaran | Dalipuga | kristelahlainegem@gmail.com |  09123456789  |      asd      |    1    |       0       |
			When  the user clicks the send button
            Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


    Scenario: Add user - address field empty
            Given I have the following user details:
			| fname   | mname |    lname   |  address |            email            | mobile_number | user_password | role_id | earned_points |
			| Kristel |   D   | Pabillaran |          | kristelahlainegem@gmail.com |  09123456789  |      asd      |    1    |       0       |
			When  the user clicks the send button
            Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


    Scenario: Add user - mname field empty
            Given I have the following user details:
			| fname   | mname |    lname   |  address |            email            | mobile_number | user_password | role_id | earned_points |
			| Kristel |       | Pabillaran | Dalipuga | kristelahlainegem@gmail.com |  09123456789  |      asd      |    1    |       0       |
			When  the user clicks the send button
            Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


    Scenario: Add user - lname field empty
            Given I have the following user details:
			| fname   | mname |    lname   |  address |            email            | mobile_number | user_password | role_id | earned_points |
			| Kristel |   D   |            | Dalipuga | kristelahlainegem@gmail.com |  09123456789  |      asd      |    1    |       0       |
			When  the user clicks the send button
            Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


    Scenario: Add user - email field empty
            Given I have the following user details:
			| fname   | mname |    lname   |  address |            email            | mobile_number | user_password | role_id | earned_points |
			| Kristel |   D   | Pabillaran | Dalipuga |                             |  09123456789  |      asd      |    1    |       0       |
			When  the user clicks the send button
            Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


      Scenario: Add user - mobile_number field empty
            Given I have the following user details:
			| fname   | mname |    lname   |  address |            email            | mobile_number | user_password | role_id | earned_points |
			| Kristel |   D   | Pabillaran | Dalipuga | kristelahlainegem@gmail.com |               |      asd      |    1    |       0       |
			When  the user clicks the send button
            Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


      Scenario: Add user - user_password field empty
            Given I have the following user details:
			| fname   | mname |    lname   |  address |            email            | mobile_number | user_password | role_id | earned_points |
			| Kristel |   D   | Pabillaran | Dalipuga | kristelahlainegem@gmail.com |  09123456789  |               |    1    |       0       |
			When  the user clicks the send button
            Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'