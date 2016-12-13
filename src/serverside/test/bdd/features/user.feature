Feature: Store User

As a business manager/customer,  I want to sign up.
As a system administrator, I want to view all users.
As a system administrator, I want to update users' details.

###############
# Sunny Cases #
###############

	Scenario: Adding user
			Given I have the following user details:
			| fname   | mname |    lname   | user_password |      email      | tel_number | mobile_number | bldg_number |   street    | room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'OK'

    Scenario: View user's information
            Given the user with an id '4'
            When  view button is clicked
            Then  it should have a '200' response
            And   it should have a field 'status' containing 'OK'
            And   it should have a field 'message' containing 'OK'
            And   the following details will be returned:
            | id | fname   | mname | lname | earned_points |      email      | tel_number | mobile_number | bldg_number |    street   | room_number | role_id |
			| 4  |  James  |   M   | Reid  |       0       | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |


#    Scenario: Update user
#             Given the details of user
#             | id | fname   | mname |    lname   |  address |            email            | mobile_number | user_password | role_id | earned_points |
#             | 12 | Kristel |   D   | Pabillaran | Dalipuga | kristelahlainegem@gmail.com |  09123456789  |      asd      |    1    |       0       |
#             And the new details of user
#             | id | fname   | mname |    lname   |  address |            email            | mobile_number | user_password | role_id | earned_points |
#             | 12 | Kristel |   P   | Reid | Dalipuga | kristelahlainegem@gmail.com |  09123456789  |      asd      |    1    |       0       |
#
#             When  the update button is clicked
#             Then  it should have a '200' response
#             And   it should have a field 'status' containing 'OK'
#
#    Scenario:  Search user
#            Given the entered keyword
#            | search |
#            |   kur  |
#            When  the search button is clicked
#            Then  it should have a '200' response
#            And   it should have a field 'status' containing 'OK'
#            And   it should have a field 'message' containing 'OK'
#            And   the following details will be returned
#            | fname   |  mname  |    lname   |  address |       email        | mobile_number | role_id | earned_points |
#			|   kur   |   dap   |     ya     |  tibanga | kurdapya@gmail.com |  09090090909  |    1    |       0       |
#
#    Scenario: Deactivate user
#             Given the user id '11' is in the database
#             When  the deactivate button is clicked
#             Then  it should have a '200' response
#             And   it should have a field 'status' containing 'OK'
#             And   it should have a field 'message' containing 'SUCCESS'



################
## Rainy Cases #
################
	Scenario: Add existing user
            Given I have the following user details:
			| fname   | mname |    lname   | user_password |      email      | tel_number | mobile_number | bldg_number |   street    | room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'OK'
            And   it should have a field 'message' containing 'OK'


	Scenario: Add user - fname field empty
           	Given I have the following user details:
			| fname   | mname |    lname   | user_password |      email      | tel_number | mobile_number | bldg_number |   street    | room_number | role_id |
			|         |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


    Scenario: Add user - mname field empty
            Given I have the following user details:
			| fname   | mname |    lname   | user_password |      email      | tel_number | mobile_number | bldg_number |   street    | room_number | role_id |
			|  James  |       |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


    Scenario: Add user - lname field empty
            Given I have the following user details:
			| fname   | mname |    lname   | user_password |      email      | tel_number | mobile_number | bldg_number |   street    | room_number | role_id |
			|   James |   M   |            |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


    Scenario: Add user - user_password field empty
            Given I have the following user details:
			| fname   | mname |    lname   | user_password |      email      | tel_number | mobile_number | bldg_number |   street    | room_number | role_id |
			|   James |   M   |    Reid    |               | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


	Scenario: Add user - email field empty
			Given I have the following user details:
			| fname   | mname |    lname   | user_password |      email      | tel_number | mobile_number | bldg_number |   street    | room_number | role_id |
			|   James |   M   |    Reid    |      asd      |                 |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
		    And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


	Scenario: Add user - tel_number field empty
			Given I have the following user details:
			| fname   | mname |    lname   | user_password |      email      | tel_number | mobile_number | bldg_number |   street    | room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |            |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
		    And   it should have a field 'message' containing 'Please fill the required fields'


	Scenario: Add user - mobile_number field empty
			Given I have the following user details:
			| fname   | mname |    lname   | user_password |      email      | tel_number | mobile_number | bldg_number |   street    | room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |               |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
		    And   it should have a field 'message' containing 'Please fill the required fields'


	Scenario: Add user - bldg_number field empty
			Given I have the following user details:
			| fname   | mname |    lname   | user_password |      email      | tel_number | mobile_number | bldg_number |   street    | room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |             | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
		    And   it should have a field 'message' containing 'Please fill the required fields'


	Scenario: Add user - street field empty
			Given I have the following user details:
			| fname   | mname |    lname   | user_password |      email      | tel_number | mobile_number | bldg_number |   street    | room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     |             |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
		    And   it should have a field 'message' containing 'Please fill the required fields'


	Scenario: Add user - room_number field empty
			Given I have the following user details:
			| fname   | mname |    lname   | user_password |      email      | tel_number | mobile_number | bldg_number |   street    | room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |             |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
		    And   it should have a field 'message' containing 'Please fill the required fields'



    Scenario: Add user - role_id field empty
            Given I have the following user details:
			| fname   | mname |    lname   | user_password |      email      | tel_number | mobile_number | bldg_number |   street    | room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |         |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'



    Scenario: View Specific User - id does not exist
            Given the user with an id '100'
            When  view button is clicked
            Then  it should have a '200' response