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
        | resto_name | min_order | delivery_fee | image_url    | email              | tel_number | mobile_number | bldg_number | street                  | room_number |
        | Frappella  | 200       | 10           | frapella.jpg | frapella@gmail.com | 283-29-34  | 09123456789   |             | Pedro Permites Rd       |             |

  When  the system administrator clicks the add button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'

Scenario: View restaurant's information
  Given the restaurant with an id '1'
  When  the view button in restaurant feature is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'
  And   the following details will be returned
        | resto_name                  | delivery_fee | min_order | email            | tel_number | mobile_number | bldg_number | street                 | room_number | image_url  | is_active |
        | Flamoo Flame Grilled Burgers| 2            | 5         | flamoo@gmail.com |  283-29-34 | 09123456789   |             |Quezon Avenue Extension |             | flamoo.jpg | t         |

Scenario: Update restaurant
  Given the restaurant with an id '1'
  And   the old details of the restuarant
        | resto_name                  | min_order | delivery_fee | image_url | email            | tel_number | mobile_number | bldg_number | street                 | room_number |
        | Flamoo Flame Grilled Burgers| 5         | 2            | flamoo.jpg| flamoo@gmail.com |  283-29-34 | 09123456789   |             |Quezon Avenue Extension |             |

  And   the new details of retaurant
        | resto_name                  | min_order | delivery_fee | image_url | email            | tel_number | mobile_number | bldg_number | street                 | room_number |
        | Flamoo Flame Grilled Burgers| 20        | 5            | flamoo.jpg| flamoo@gmail.com |  283-29-34 | 09123456789   |             |Quezon Avenue Extension |             |

  When  the update button of restaurant is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'



###############
 # Rainy Cases #
 ###############

 Scenario: Add restaurant - restaurant branch name already exists.
  Given the system administrator have the following restaurant details:
        | resto_name | min_order | delivery_fee | image_url    | email              | tel_number | mobile_number | bldg_number | street                  | room_number |
        | Frappella  | 200       | 10           | frapella.jpg | frapella@gmail.com | 283-29-34  | 09123456789   |             | Pedro Permites Rd       |             |

  When  the system administrator clicks the add button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Restaurant branch already exists.'

 Scenario: Add restaurant - resto name field is empty
  Given the system administrator have the following restaurant details:
        | resto_name | min_order | delivery_fee | image_url    | email              | tel_number | mobile_number | bldg_number | street                  | room_number |
        |            | 200       | 10           | frapella.jpg | frapella@gmail.com | 283-29-34  | 09123456789   |             | Pedro Permites Rd       |             |

  When  the system administrator clicks the add button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

 Scenario: Add restaurant - image field is empty
  Given the system administrator have the following restaurant details:
        | resto_name | min_order | delivery_fee | image_url    | email              | tel_number | mobile_number | bldg_number | street                  | room_number |
        | Frappella  | 200       | 10           |              | frapella@gmail.com | 283-29-34  | 09123456789   |             | Pedro Permites Rd       |             |

  When  the system administrator clicks the add button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

 Scenario: Add restaurant - street field is empty
  Given the system administrator have the following restaurant details:
        | resto_name | min_order | delivery_fee | image_url    | email              | tel_number | mobile_number | bldg_number | street                  | room_number |
        | Frappella  | 200       | 10           | frapella.jpg | frapella@gmail.com | 283-29-34  | 09123456789   |             |                         |             |

  When  the system administrator clicks the add button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

 Scenario: Add restaurant - email field is empty
  Given the system administrator have the following restaurant details:
        | resto_name | min_order | delivery_fee | image_url    | email              | tel_number | mobile_number | bldg_number | street                  | room_number |
        | Frappella  | 200       | 10           | frapella.jpg |                    | 283-29-34  | 09123456789   |             | Pedro Permites Rd       |             |

  When  the system administrator clicks the add button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

 Scenario: Add restaurant - telephone number field is empty
  Given the system administrator have the following restaurant details:
        | resto_name | min_order | delivery_fee | image_url    | email              | tel_number | mobile_number | bldg_number | street                  | room_number |
        | Frappella  | 200       | 10           | frapella.jpg | frapella@gmail.com |            | 09123456789   |             | Pedro Permites Rd       |             |

  When  the system administrator clicks the add button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

 Scenario: Add restaurant - mobile number field is empty
  Given the system administrator have the following restaurant details:
        | resto_name | min_order | delivery_fee | image_url    | email              | tel_number | mobile_number | bldg_number | street                  | room_number |
        | Frappella  | 200       | 10           | frapella.jpg | frapella@gmail.com | 283-29-34  |               |             | Pedro Permites Rd       |             |

  When  the system administrator clicks the add button
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

Scenario: View Specific Restaurant - id does not exist
  Given the restaurant with an id '10000'
  When  the view button in restaurant feature is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'No Restaurant Found'

Scenario: Update restaurant - resto name field is empty
  Given the restaurant with an id '1'
  And   the old details of the restuarant
        | resto_name                  | min_order | delivery_fee | image_url | email            | tel_number | mobile_number | bldg_number | street                 | room_number |
        | Flamoo Flame Grilled Burgers| 5         | 2            | flamoo.jpg| flamoo@gmail.com |  283-29-34 | 09123456789   |             |Quezon Avenue Extension |             |

  And   the new details of retaurant
        | resto_name | min_order | delivery_fee | image_url    | email              | tel_number | mobile_number | bldg_number | street                  | room_number |
        |            | 200       | 10           | frapella.jpg | frapella@gmail.com | 283-29-34  | 09123456789   |             | Pedro Permites Rd       |             |

  When  the update button of restaurant is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

Scenario: Update restaurant - street field is empty
  Given the restaurant with an id '1'
  And   the old details of the restuarant
        | resto_name                  | min_order | delivery_fee | image_url | email            | tel_number | mobile_number | bldg_number | street                 | room_number |
        | Flamoo Flame Grilled Burgers| 5         | 2            | flamoo.jpg| flamoo@gmail.com |  283-29-34 | 09123456789   |             |Quezon Avenue Extension |             |

  And   the new details of retaurant
        | resto_name                  | min_order | delivery_fee | image_url | email            | tel_number | mobile_number | bldg_number | street                 | room_number |
        | Flamoo Flame Grilled Burgers| 5         | 2            | flamoo.jpg| flamoo@gmail.com |  283-29-34 | 09123456789   |             |                        |             |

  When  the update button of restaurant is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

Scenario: Update restaurant - email field is empty
  Given the restaurant with an id '1'
  And   the old details of the restuarant
        | resto_name                  | min_order | delivery_fee | image_url | email            | tel_number | mobile_number | bldg_number | street                 | room_number |
        | Flamoo Flame Grilled Burgers| 5         | 2            | flamoo.jpg| flamoo@gmail.com |  283-29-34 | 09123456789   |             |Quezon Avenue Extension |             |

  And   the new details of retaurant
        | resto_name                  | min_order | delivery_fee | image_url | email            | tel_number | mobile_number | bldg_number | street                 | room_number |
        | Flamoo Flame Grilled Burgers| 5         | 2            | flamoo.jpg|                  |  283-29-34 | 09123456789   |             |Quezon Avenue Extension |             |

  When  the update button of restaurant is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

Scenario: Update restaurant - telephone number field is empty
  Given the restaurant with an id '1'
  And   the old details of the restuarant
        | resto_name                  | min_order | delivery_fee | image_url | email            | tel_number | mobile_number | bldg_number | street                 | room_number |
        | Flamoo Flame Grilled Burgers| 5         | 2            | flamoo.jpg| flamoo@gmail.com |  283-29-34 | 09123456789   |             |Quezon Avenue Extension |             |

  And   the new details of retaurant
        | resto_name                  | min_order | delivery_fee | image_url | email            | tel_number | mobile_number | bldg_number | street                 | room_number |
        | Flamoo Flame Grilled Burgers| 5         | 2            | flamoo.jpg| flamoo@gmail.com |            | 09123456789   |             |Quezon Avenue Extension |             |

  When  the update button of restaurant is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

Scenario: Update restaurant - mobile number field is empty
  Given the restaurant with an id '1'
  And   the old details of the restuarant
        | resto_name                  | min_order | delivery_fee | image_url | email            | tel_number | mobile_number | bldg_number | street                 | room_number |
        | Flamoo Flame Grilled Burgers| 5         | 2            | flamoo.jpg| flamoo@gmail.com |  283-29-34 | 09123456789   |             |Quezon Avenue Extension |             |

  And   the new details of retaurant
        | resto_name                  | min_order | delivery_fee | image_url | email            | tel_number | mobile_number | bldg_number | street                 | room_number |
        | Flamoo Flame Grilled Burgers| 5         | 2            | flamoo.jpg| flamoo@gmail.com |  283-29-34 |               |             |Quezon Avenue Extension |             |

  When  the update button of restaurant is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'
