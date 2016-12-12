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