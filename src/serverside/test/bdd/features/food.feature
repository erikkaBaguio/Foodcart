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