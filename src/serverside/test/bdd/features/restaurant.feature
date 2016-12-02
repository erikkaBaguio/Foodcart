Feature: Store Restaurant

As a system administrator, I want to add new restaurant information.

###############
# Sunny Cases #
###############

Scenario: Add restaurant successfully.
  Given the system administrator have the following restaurant details:
		| resto_name | min_order | delivery_fee | location 			   |
		| Cozy Cup	 | 200 		 | 10			| Tibanga, Iligan City |
            

  When  the system administrator clicks the send button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'


 ###############
 # Rainy Cases #
 ###############

 Scenario: Add restaurant - resto name field is empty
  Given the system administrator have the following restaurant details:
		| resto_name | min_order | delivery_fee | location 			   |
		| 			 | 200 		 | 10			| Tibanga, Iligan City |
            

  When  the system administrator clicks the send button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'


 Scenario: Add restaurant - location field is empty
  Given the system administrator have the following restaurant details:
		| resto_name | min_order | delivery_fee | location 			   |
		| Cozy Cup	 | 200 		 | 10			| 					   |
            

  When  the system administrator clicks the send button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'