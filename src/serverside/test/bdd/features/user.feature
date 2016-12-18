Feature: Store User

As a business manager/customer,  I want to sign up.
As a system administrator, I want to view all users.
As a system administrator, I want to update users' details.

###############
# Sunny Cases #
###############

	Scenario: Adding user
			Given I have the following user details:
			| fname   | mname |    lname   | user_password | user_email      | user_tel_number | user_mobile_number | user_bldg_number |   user_street    | user_room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'OK'

    Scenario: View user's information
            Given the user with an id '1'
            When  view button is clicked
            Then  it should have a '200' response
            And   the following details will be returned:
            | id | fname   | mname | lname | earned_points |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number | role_id |
			| 1  |  James  |   M   | Reid  |       0       | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |


    Scenario: Update user
             Given the user with an id '3'
			 And the old details of user
		     | id | update_fname | update_mname | update_lname | update_user_password | update_earned_points | contact_id | address_id | role_id | is_active |
             | 3  |    Kristel   |    Ahlaine   |      Gem     |         asdasd       |          100         |      3     |      3     |    1    |    TRUE   |
             And the new details of user
             | id | update_fname | update_mname | update_lname | update_user_password | update_earned_points |
             | 3  |    Kristel   |    Ahlaine   |  Pabillaran  |        asdasd        |          100         |
		     When  the update button is clicked
             Then  it should have a '200' response
             And   it should have a field 'status' containing 'OK'


    Scenario:  Search user
            Given the entered keyword for user
            | search |
            | James  |
            When  the search button for user is clicked
            Then  it should have a '200' response
            And   it should have a field 'status' containing 'OK'
            And   it should have a field 'message' containing 'OK'
            And   the following details will be returned
            |  fname  |  mname  | lname  | earned_points | role_id |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number |
			|  James  |    M    |  Reid  |       0       |    1    | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |


    Scenario: Deactivate user
             Given the user id '1' is in the database
             When  the deactivate button is clicked
             Then  it should have a '200' response
             And   it should have a field 'status' containing 'OK'
             And   it should have a field 'message' containing 'SUCCESS'



################
## Rainy Cases #
################
	Scenario: Add existing user
            Given I have the following user details:
			| fname   | mname |    lname   | user_password |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'OK'
            And   it should have a field 'message' containing 'OK'


	Scenario: Add user - fname field empty
           	Given I have the following user details:
			| fname   | mname |    lname   | user_password |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number | role_id |
			|         |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


    Scenario: Add user - mname field empty
            Given I have the following user details:
			| fname   | mname |    lname   | user_password |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number | role_id |
			|  James  |       |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


    Scenario: Add user - lname field empty
            Given I have the following user details:
			| fname   | mname |    lname   | user_password |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number | role_id |
			|   James |   M   |            |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


    Scenario: Add user - user_password field empty
            Given I have the following user details:
			| fname   | mname |    lname   | user_password |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number | role_id |
			|   James |   M   |    Reid    |               | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


	Scenario: Add user - email field empty
			Given I have the following user details:
			| fname   | mname |    lname   | user_password |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number | role_id |
			|   James |   M   |    Reid    |      asd      |                 |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
		    And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'


	Scenario: Add user - tel_number field empty
			Given I have the following user details:
			| fname   | mname |    lname   | user_password |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |            |  09090090909  |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
		    And   it should have a field 'message' containing 'Please fill the required fields'


	Scenario: Add user - mobile_number field empty
			Given I have the following user details:
			| fname   | mname |    lname   | user_password |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |               |      12     | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
		    And   it should have a field 'message' containing 'Please fill the required fields'


	Scenario: Add user - bldg_number field empty
			Given I have the following user details:
			| fname   | mname |    lname   | user_password |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |             | Street Shop |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
		    And   it should have a field 'message' containing 'Please fill the required fields'


	Scenario: Add user - street field empty
			Given I have the following user details:
			| fname   | mname |    lname   | user_password |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     |             |      4B     |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
		    And   it should have a field 'message' containing 'Please fill the required fields'


	Scenario: Add user - room_number field empty
			Given I have the following user details:
			| fname   | mname |    lname   | user_password |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |             |    1    |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
		    And   it should have a field 'message' containing 'Please fill the required fields'



    Scenario: Add user - role_id field empty
            Given I have the following user details:
			| fname   | mname |    lname   | user_password |      user_email      | user_tel_number | user_mobile_number | user_bldg_number | user_street   | user_room_number | role_id |
			|   James |   M   |    Reid    |      asd      | james@gmail.com |  225-1234  |  09090090909  |      12     | Street Shop |      4B     |         |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'FAILED'
            And   it should have a field 'message' containing 'Please fill the required fields'



    Scenario: View Specific User - id does not exist
            Given the user with an id '100'
            When  view button is clicked
            Then  it should have a '200' response