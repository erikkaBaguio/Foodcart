Feature: Store Restaurant

As a system administrator, I want to add new restaurant information.
As a business manager or a customer, I want to view restaurant's information.
As a business manager, I want to update the restaurant’s information.

###############
# Sunny Cases #
###############

Scenario: Add restaurant successfully.
  Given the system administrator have the following restaurant details:
    | resto_name | min_order | delivery_fee | location             |
    | Frappella   | 200       |       10     | Tibanga, Iligan City|
            

  When  the system administrator clicks the send button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'

Scenario: View restaurant's information
  Given the restaurant with an id '1'
  When  the view button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'
  And   the following details will be returned
    | resto_name | min_order | delivery_fee | location             |
    | Jollibee   | 5         | 2            | Tibanga, Iligan City |

Scenario: Update restaurant
  Given the details of restaurant
    | resto_name | min_order | delivery_fee | location             |
    | Jollibee   | 5         | 2            | Tibanga, Iligan City |

  And the new details of retaurant
    | resto_name | min_order | delivery_fee | location             |
    | Jollibee   | 20        | 10           | Tibanga, Iligan City |

  When  the update button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'





 ###############
 # Rainy Cases #
 ###############

 Scenario: Add restaurant - restaurant's name already exists.
  Given the system administrator have the following restaurant details:
    | resto_name | min_order | delivery_fee | location             |
    | Cozy Cup   | 200       |       10     | Tibanga, Iligan City |
            

  When  the system administrator clicks the send button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'

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

 Scenario: View Speccific Restaurant - id does not exist
  Given the restaurant with an id '1000'
  When  the view button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'No Restaurant Found'