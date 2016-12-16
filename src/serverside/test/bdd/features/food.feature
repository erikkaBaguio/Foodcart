Feature: Food

As a business manager, I want to add food

###############
# Sunny Cases #
###############

Scenario: Add food successfully.
  Given following food details:
        | food_name   | description 										| unit_cost  | image_url     | resto_id |
        | Tacorella   | A taste of famous Mexican taco delicacy in a pizza. |     299    | tacorella.jpg | 1        |

  When  add button for food is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'

Scenario: View food
  Given the restaurant id '1' and food id '1'
  When  the view button for food is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'
  And   the following details will be returned
        | food_id | food_name	| description 										 | unit_cost  | is_active | is_available | image_url  |
        | 1       | Madcow      | The original hot and spicy pizza in the world.     |     299    | true      | true         | madcow.jpg |

Scenario: Update food
  Given the food with an id '1'
  And   the old details of the food
        | food_name   | description                                       | unit_cost  | image_url  |
        | Madcow      | The original hot and spicy pizza in the world.    |     299    | madcow.jpg |

  And   the new details of food
        | food_name   | description                                       | unit_cost  | image_url  |
        | Madcow      | The original hot and spicy pizza in the world.    |     300    | madcow.jpg |

  When  the update button for food is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'

Scenario: Search food
  Given the entered keyword for food
        |search                      |
        |Madcow                      |

  When  the search button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'
  And   the following details will be returned
        | food_id | food_name	| description 										  | unit_cost  | resto_id | image_id | is_available | is_active |
        | 1       | Madcow      | The original hot and spicy pizza in the world.      |     300    | true     | true     | true         | true      |


###############
# Rainy Cases #
###############

Scenario: Add food - food name already exists
  Given following food details:
        | food_name	  | description 										| unit_cost  | image_url     | resto_id |
        | Tacorella   | A taste of famous Mexican taco delicacy in a pizza. |     299    | tacorella.jpg | 1        |

  When  add button for food is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'EXISTED'

Scenario: Add food - food name field is empty
  Given following food details:
        | food_name	  | description 										| unit_cost  | image_url     | resto_id |
        |             | A taste of famous Mexican taco delicacy in a pizza. |     299    | tacorella.jpg | 1        |

  When  add button for food is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

Scenario: Add food - unit cost field is empty
  Given following food details:
        | food_name	  | description 										| unit_cost  | image_url     | resto_id |
        | Tacorella   | A taste of famous Mexican taco delicacy in a pizza. |            | tacorella.jpg | 1        |

  When  add button for food is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

Scenario: View food
  Given the restaurant id '1000' and food id '3'
  When  the view button for food is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'No food found'

Scenario: Update food - unit cost field is empty
  Given the food with an id '1'
  And   the old details of the food
        | food_name   | description                                       | unit_cost  | image_url  |
        | Madcow      | The original hot and spicy pizza in the world.    |     300    | madcow.jpg |

  And   the new details of food
        | food_name   | description                                       | unit_cost  | image_url  |
        | Madcow      | The original hot and spicy pizza in the world.    |            | madcow.jpg |
  When  the update button for food is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'

Scenario: Deactivate food
  Given the food id '1' is in the database
  When  the deactivate button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'SUCCESS'

Scenario: Search food - the keyword do not match to any food
  Given the entered keyword
        |search  |
        |q       |
  When  the search button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'No data matched your search'