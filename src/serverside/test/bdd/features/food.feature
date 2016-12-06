Feature: Food

As a business manager, I want to add food

###############
# Sunny Cases #
###############

Scenario: Add food successfully.
  Given following food details:
    | food_name	  | description 										| unit_cost  |
    | Tacorella   | A taste of famous Mexican taco delicacy in a pizza. |     299    |
            
  When  add button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'

Scenario: View food
  Given the food with an id '1'
  When  the view button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'OK'
  And   the following details will be returned
    | food_name	  | description 										| unit_cost  |
    | Madcow   	  | The original hot and spicy pizza in the world.		|     299    |


###############
# Rainy Cases #
###############

Scenario: Add food - food name already exists
  Given following food details:
    | food_name	  | description 										| unit_cost  |
    | Tacorella   | A taste of famous Mexican taco delicacy in a pizza. |     299    |            

  When  add button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'OK'
  And   it should have a field 'message' containing 'EXISTED' 

Scenario: Add food - food name field is empty
  Given following food details:
    | food_name	  | description 										| unit_cost  |
    | 	          | A taste of famous Mexican taco delicacy in a pizza. |     299    | 

  When  add button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'  

Scenario: Add food - description field is empty
  Given following food details:
    | food_name	  | description 										| unit_cost  |
    | Tacorella   |														|     299    | 

  When  add button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields' 

Scenario: Add food - unit cost field is empty
  Given following food details:
    | food_name	  | description 										| unit_cost  |
    | Tacorella   | A taste of famous Mexican taco delicacy in a pizza. |            | 

  When  add button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'Please fill the required fields'     

Scenario: View food
  Given the food with an id '1000'
  When  the view button is clicked
  Then  it should have a '200' response
  And   it should have a field 'status' containing 'FAILED'
  And   it should have a field 'message' containing 'No food found'  