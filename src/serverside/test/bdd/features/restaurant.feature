Feature: Restaurant

As a system administrator, I want to add new restaurant information.
As a business manager or a customer, I want to view restaurant's information.
As a business manager, I want to update the restaurant’s information.
As a system administrator, I want to deactivate restaurant.
As a customer, I want to search restaurants.


###############
# Sunny Cases #
###############

Scenario: Add restaurant successfully.
  Given the system administrator have the following restaurant details:
    | resto_name | min_order | delivery_fee | location             |
    | Frappella  | 200       |10            | Tibanga, Iligan City |
            

  When  the system administrator clicks the add button
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
    | resto_name                  | min_order | delivery_fee | location                             |
    | Flamoo Flame Grilled Burgers| 5         | 2            | Quezon Avenue Extension, Iligan City |

Scenario: Update restaurant
  Given the restaurant with an id '1'
  And the old details of the restuarant
    | resto_name                  | min_order   | delivery_fee | location                             |
    | Flamoo Flame Grilled Burgers| 5           | 2            | Quezon Avenue Extension, Iligan City |


  And the new details of retaurant
    | resto_name                  | min_order   | delivery_fee | location                             |
    | Flamoo Flame Grilled Burgers| 100         | 2            | Quezon Avenue Extension, Iligan City |

  When  the update button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'

Scenario: Deactivate restaurant
  Given the restaurant id '1' is in the database
  When  the deactivate button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'SUCCESS'

Scenario: Search restaurant
  Given the entered keyword
        |search                      |
        |Flamoo Flame Grilled Burgers|
  When  the search button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'
  And   the following details will be returned
        | resto_name                  | min_order   | delivery_fee | location                             |
        | Flamoo Flame Grilled Burgers| 100         | 2            | Quezon Avenue Extension, Iligan City |


###############
 # Rainy Cases #
 ###############

 Scenario: Add restaurant - restaurant's name already exists.
  Given the system administrator have the following restaurant details:
    | resto_name | min_order | delivery_fee | location             |
    | Frappella  | 200       |10            | Tibanga, Iligan City |
            

  When  the system administrator clicks the add button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'EXISTED'

 Scenario: Add restaurant - resto name field is empty
  Given the system administrator have the following restaurant details:
    | resto_name | min_order | delivery_fee | location             |
    |            | 200       | 10           | Tibanga, Iligan City |
            

  When  the system administrator clicks the add button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

 Scenario: Add restaurant - location field is empty
  Given the system administrator have the following restaurant details:
    | resto_name | min_order | delivery_fee | location         |
    | Cozy Cup   | 200       | 10           |                  |
            

  When  the system administrator clicks the add button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

 Scenario: View Specific Restaurant - id does not exist
  Given the restaurant with an id '1000'
  When  the view button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'No Restaurant Found'

Scenario: Update restaurant - restaurant name field is empty
  Given the restaurant with an id '1'
  And the old details of the restuarant
    | resto_name                  | min_order   | delivery_fee | location                             |
    | Flamoo Flame Grilled Burgers| 100         | 2            | Quezon Avenue Extension, Iligan City |

  And the new details of retaurant
    | resto_name                  | min_order   | delivery_fee | location                             |
    |                             | 100         | 2            | Quezon Avenue Extension, Iligan City |

  When  the update button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

Scenario: Update restaurant - minimum order field is empty
  Given the restaurant with an id '1'
  And the old details of the restuarant
    | resto_name                  | min_order   | delivery_fee | location                             |
    | Flamoo Flame Grilled Burgers| 100         | 2            | Quezon Avenue Extension, Iligan City |

  And the new details of retaurant
    | resto_name                  | min_order   | delivery_fee | location                             |
    | Flamoo Flame Grilled Burgers|             | 2            | Quezon Avenue Extension, Iligan City |

  When  the update button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

Scenario: Update restaurant - delivery fee field is empty
  Given the restaurant with an id '1'
  And the old details of the restuarant
    | resto_name                  | min_order   | delivery_fee | location                             |
    | Flamoo Flame Grilled Burgers| 100         | 2            | Quezon Avenue Extension, Iligan City |

  And the new details of retaurant
    | resto_name                  | min_order   | delivery_fee | location                             |
    | Flamoo Flame Grilled Burgers| 100         |             | Quezon Avenue Extension, Iligan City |

  When  the update button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

Scenario: Update restaurant - location field is empty
  Given the restaurant with an id '1'
  And the old details of the restuarant
    | resto_name                  | min_order   | delivery_fee | location                             |
    | Flamoo Flame Grilled Burgers| 100         | 2            | Quezon Avenue Extension, Iligan City |

  And the new details of retaurant
    | resto_name                  | min_order   | delivery_fee | location                             |
    | Flamoo Flame Grilled Burgers| 100         | 2            |                                      |

  When  the update button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'