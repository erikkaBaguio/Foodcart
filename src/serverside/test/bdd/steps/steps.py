from lettuce import step, world, before
from nose.tools import assert_equals
from webtest import TestApp
from app import app
import base64
import json


@before.all
def before_all():
    world.app = app.test_client()


""" Common steps for jsonify response """


@step(u'Then  it should have a \'([^\']*)\' response')
def then_it_should_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And   it should have a field \'([^\']*)\' containing \'([^\']*)\'')
def and_it_should_get_a_field_group1_containing_group2(step, field, expected_value):
    world.response_json = json.loads(world.response.data)
    assert_equals(str(world.response_json[field]), expected_value)


@step(u'And   the following details will be returned')
def and_the_following_details_will_be_returned(step):
    response_json = json.loads(world.response.data)
    assert_equals(world.response_json['entries'], response_json['entries'])




""" Steps for Food feature """

""" Add Food """

@step(u'Given following food details:')
def given_following_food_details(step):
    world.restaurant = step.hashes[0]

@step(u'When  add button for food is clicked')
def when_add_button_for_food_is_clicked(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/foods/', data=json.dumps(world.restaurant))


""" View Food """

@step(u'Given the restaurant id \'([^\']*)\' and food id \'([^\']*)\'')
def given_the_restaurant_id_group1_and_food_id_group2(step, resto_id, food_id):
    world.resto_id = resto_id
    world.food_id = food_id
    world.food = world.app.get('/api/foodcart/foods/{}/{}'.format(resto_id,food_id))
    world.response_json = json.loads(world.food.data)

@step(u'When  the view button for food is clicked')
def when_the_view_button_for_food_is_clicked(step):
    world.response = world.app.get('/api/foodcart/foods/{}/{}'.format(world.resto_id, world.food_id))


""" Update Food """
@step(u'Given the food with an id \'([^\']*)\'')
def given_the_food_with_an_id_group1(step, food_id):
    world.food_id = food_id


@step(u'And   the old details of the food')
def and_the_old_details_of_the_food(step):
    world.food_oldInfo = step.hashes[0]

@step(u'And   the new details of food')
def and_the_new_details_of_food(step):
    world.food_updatedInfo = step.hashes[0]

@step(u'When  the update button for food is clicked')
def when_the_update_button_for_food_is_clicked(step):
    world.response = world.app.put('/api/foodcart/foods/{}'.format(world.food_id), data=json.dumps(world.food_updatedInfo))


""" Deactivate Food """

@step(u'Given the food id \'([^\']*)\' is in the database')
def given_the_food_id_group1_is_in_the_database(step, food_id):
    world.food_id = food_id

@step(u'When  the deactivate button for food is clicked')
def when_the_deactivate_button_for_food__is_clicked(step):
    world.browser = TestApp(app)
    world.response = world.app.put('/api/foodcart/foods/deactivate/{}'.format(world.food_id))


""" Search Food """

@step(u'Given the entered keyword for food')
def given_the_entered_keyword_for_food(step):
    world.food_keyword = step.hashes[0]


@step(u'When  the search button for food is clicked')
def when_the_search_button_for_food_is_clicked(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/foods/search/', data=json.dumps(world.food_keyword))



"""Log In"""

@step(u'Given I have the following login details:')
def given_login_details(step):
    world.login = step.hashes[0]


@step(u'When I click login button')
def when_i_click_login_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/users/login/', data = json.dumps(world.login))

@step(u'Then I get a \'(.*)\' response')
def then_i_should_get_a_200_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And a message "Successfully Logged In" is returned')
def message_res(step):
    world.respn = json.loads(world.response.data)
    assert_equals(world.respn['message'], "Successfully Logged In")


@step(u'And a message "Invalid email or password" is returned')
def message_res(step):
    world.respn = json.loads(world.response.data)
    assert_equals(world.respn['message'], "Invalid email or password")





"""Orders"""

@step(u'Given I have the following order details:')
def user_details(step):
    world.orders = step.hashes[0]

@step(u'When the user clicks the add button')
def when_the_user_clicks_the_send_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/orders/', data=json.dumps(world.orders))




""" Steps for Restaurant feature """

""" Add Restaurant """

@step(u'Given the system administrator have the following restaurant details:')
def given_the_system_administrator_have_the_following_restaurant_details(step):
    world.restaurant = step.hashes[0]

@step(u'When  the system administrator clicks the add button')
def when_the_system_administrator_clicks_the_add_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/restaurants/', data=json.dumps(world.restaurant))


""" View Restaurant """

@step(u'Given the restaurant with an id \'([^\']*)\'')
def given_the_restaurant_with_an_id_group1(step, resto_id):
    world.resto_id = resto_id
    world.restaurant = world.app.get('/api/foodcart/restaurants/{}'.format(resto_id))
    world.response_json = json.loads(world.restaurant.data)

@step(u'When  the view button in restaurant feature is clicked')
def when_the_view_button_in_restaurant_feature_is_clicked(step):
    world.response = world.app.get('/api/foodcart/restaurants/{}'.format(world.resto_id))


""" Update Restaurant """

@step(u'And   the old details of the restuarant')
def and_the_old_details_of_the_restuarant(step):
    world.restaurant_oldInfo = step.hashes[0]

@step(u'And   the new details of retaurant')
def and_the_new_details_of_retaurant(step):
    world.restaurant_updatedInfo = step.hashes[0]

@step(u'When  the update button of restaurant is clicked')
def when_the_update_button_of_restaurant_is_clicked(step):
    world.response = world.app.put('/api/foodcart/restaurants/1', data=json.dumps(world.restaurant_updatedInfo))


""" Deactivate Restaurant """

@step(u'Given the restaurant id \'([^\']*)\' is in the database')
def given_the_restaurant_id_group1_is_in_the_database(step, resto_id):
    world.resto_id = resto_id

@step(u'When  the deactivate button for restaurant is clicked')
def when_the_deactivate_button_for_restaurant_is_clicked(step):
    world.browser = TestApp(app)
    world.response = world.app.put('/api/foodcart/restaurants/deactivate/{}'.format(world.resto_id))


""" Search Restaurant """

@step(u'Given the entered keyword for restaurant')
def given_the_entered_keyword_for_restaurant(step):
    world.restaurant_keyword = step.hashes[0]


@step(u'When  the search button for restaurant is clicked')
def when_the_search_button_for_restaurant_is_clicked(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/restaurants/search/', data=json.dumps(world.restaurant_keyword))




"""Steps for User feature"""

"""Adding User"""


@step(u'Given I have the following user details:')
def user_details(step):
    world.user = step.hashes[0]


@step(u'When  the user clicks the send button')
def when_the_user_clicks_the_send_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/users/signup/', data=json.dumps(world.user))


"""Retrieving User"""


@step(u'Given the user with an id \'([^\']*)\'')
def given_the_user_with_an_id_group1(step, id):
    world.user_id = id
    world.user = world.app.get('/api/foodcart/users/{}/'.format(id))
    world.response_json = json.loads(world.user.data)


@step(u'When  view button is clicked')
def when_the_view_button_is_clicked(step):
    world.response = world.app.get('/api/foodcart/users/{}/'.format(world.user_id))


"""Updating User"""

@step(u'And the old details of user')
def and_the_old_details_of_the_food(step):
    world.user_oldInfo = step.hashes[0]


@step(u'And the new details of user')
def and_the_new_details_of_user(step):
    world.user_updatedInfo = step.hashes[0]


@step(u'When  the update button is clicked')
def when_the_update_button_is_clicked(step):
    world.response = world.app.put('/api/foodcart/users/update/3/', data=json.dumps(world.user_updatedInfo))


"""Search User"""

@step(u'Given the entered keyword for user')
def given_the_entered_keyword_for_user(step):
    world.user_keyword = step.hashes[0]


@step(u'When  the search button for user is clicked')
def when_the_search_button_for_user_is_clicked(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/users/search/', data=json.dumps(world.user_keyword))


"""Deactivating User"""

@step(u'Given the user id \'([^\']*)\' is in the database')
def given_the_user_id_group1_is_in_the_database(step, id):
    world.user_id = id


@step(u'When  the deactivate button is clicked')
def when_the_deactivate_button_is_clicked(step):
    world.browser = TestApp(app)
    world.response = world.app.put('/api/foodcart/users/deactivate/{}/'.format(world.user_id))


"""Log In"""

@step(u'Given I have the following login details:')
def given_login_details(step):
    world.login = step.hashes[0]


@step(u'When I click login button')
def when_i_click_login_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/users/login/', data = json.dumps(world.login))

@step(u'Then I get a \'(.*)\' response')
def then_i_should_get_a_200_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And a message "Successfully Logged In" is returned')
def message_res(step):
    world.respn = json.loads(world.response.data)
    assert_equals(world.respn['message'], "Successfully Logged In")


@step(u'And a message "Invalid email or password" is returned')
def message_res(step):
    world.respn = json.loads(world.response.data)
    assert_equals(world.respn['message'], "Invalid email or password")


"""Orders"""


@step(u'Given I have the following order details:')
def user_details(step):
    world.orders = step.hashes[0]


@step(u'When the user clicks the add button')
def when_the_user_clicks_the_send_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/orders/add/', data=json.dumps(world.orders))


@step(u'Given the order with an id \'([^\']*)\'')
def given_the_user_with_an_id_group1(step, id):
    world.order_id = id
    world.order = world.app.get('/api/foodcart/orders/{}/'.format(id))
    world.response_json = json.loads(world.order.data)


@step(u'When  view is clicked')
def when_the_view_button_is_clicked(step):
    world.response = world.app.get('/api/foodcart/orders/{}/'.format(world.order_id))


"""Transactions"""

@step(u'Given I have the following transaction details:')
def user_details(step):
    world.transaction = step.hashes[0]


@step(u'When the user clicks the add button for transaction')
def when_the_user_clicks_the_send_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/transactions/add/', data=json.dumps(world.transaction))


@step(u'Given the transaction with an id \'([^\']*)\'')
def given_the_user_with_an_id_group1(step, id):
    world.trans_id = id
    world.transaction = world.app.get('/api/foodcart/transactions/{}/'.format(id))
    world.response_json = json.loads(world.transaction.data)


@step(u'When  view button for transaction is clicked')
def when_the_view_button_is_clicked(step):
    world.response = world.app.get('/api/foodcart/transactions/{}/'.format(world.trans_id))