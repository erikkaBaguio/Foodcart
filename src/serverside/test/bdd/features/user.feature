Feature: Store User

As a business manager/customer,  I want to sign up.
As a system administrator, I want to view all users.
As a system administrator, I want to update users' details.

###############
# Sunny Cases #
###############

	Scenario: Adding user
			Given I have the following user details:
			| fname   | mname |    lname   |  address |            email            | mobile_number | user_password | role_id | earned_points |
			| Kristel |   D   | Pabillaran | Dalipuga | kristelahlainegem@gmail.com |  09123456789  |      asd      |    1    |       0       |
			When  the user clicks the send button
			Then  it should have a '200' response
            And   it should have a field 'status' containing 'OK'
			And   it should have a field 'message' containing 'OK'

    Scenario: View user's information
            Given the user with an id '3'
            When  view button is clicked
            Then  it should have a '200' response
            And   it should have a field 'status' containing 'OK'
            And   it should have a field 'message' containing 'OK'
            And   the following details will be returned:
            | id | fname   | mname | lname | address |     email     | mobile_number | role_id | earned_points |
			| 3  | ahlaine | gem   |  pabs |  iligan | gem@gmail.com |     0123      |    1    |       0       |

    Scenario: Update user
             Given the details of user
             | id | fname   | mname |    lname   |  address |            email            | mobile_number | user_password | role_id | earned_points |
             | 12 | Kristel |   D   | Pabillaran | Dalipuga | kristelahlainegem@gmail.com |  09123456789  |      asd      |    1    |       0       |
             And the new details of user
             | id | fname   | mname |    lname   |  address |            email            | mobile_number | user_password | role_id | earned_points |
             | 12 | Kristel |   P   | Reid | Dalipuga | kristelahlainegem@gmail.com |  09123456789  |      asd      |    1    |       0       |

             When  the update button is clicked
             Then  it should have a '200' response
             And   it should have a field 'status' containing 'OK'

    Scenario:  Search user
            Given the entered keyword
            | search |
            |   kur  |
            When  the search button is clicked
            Then  it should have a '200' response
            And   it should have a field 'status' containing 'OK'
            And   it should have a field 'message' containing 'OK'
            And   the following details will be returned
            | fname   |  mname  |    lname   |  address |       email        | mobile_number | role_id | earned_points |
			|   kur   |   dap   |     ya     |  tibanga | kurdapya@gmail.com |  09090090909  |    1    |       0       |



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


       Scenario: View Specific User - id does not exist
            Given the restaurant with an id '1'
            When  view button is clicked
            Then  it should have a '200' response