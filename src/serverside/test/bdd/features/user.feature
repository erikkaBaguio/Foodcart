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