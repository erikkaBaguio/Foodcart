from lettuce import step, world, before
from nose.tools import assert_equals
from webtest import TestApp
from app import app
import base64
import json


@before.all
def before_all():
    world.app = app.test_client()


"""Add new restaurant"""


@step(u'Given the system administrator have the following restaurant details:')
def given_the_system_administrator_have_the_following_restaurant_details(step):
    world.restaurant = step.hashes[0]


@step(u'When  the system administrator clicks the send button')
def when_the_system_administrator_clicks_the_send_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/restaurants/', data=json.dumps(world.restaurant))


@step(u'Given the restaurant with an id \'([^\']*)\'')
def given_the_restaurant_with_an_id_group1(step, resto_id):
    world.resto_id = resto_id
    world.restaurant = world.app.get('/api/foodcart/restaurants/{}'.format(resto_id))
    world.response_json = json.loads(world.restaurant.data)


@step(u'When  the view button is clicked')
def when_the_view_button_is_clicked(step):
    world.response = world.app.get('/api/foodcart/restaurants/{}'.format(world.resto_id))


@step(u'And   the following details will be returned')
def and_the_following_details_will_be_returned(step):
    response_json = json.loads(world.response.data)
    assert_equals(world.response_json['entries'], response_json['entries'])


"""User"""
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


@step(u'Given the details of user')
def given_the_details_of_user(step):
    world.user_oldInfo = step.hashes[0]


@step(u'And the new details of user')
def and_the_new_details_of_user(step):
    world.user_updatedInfo = step.hashes[0]


@step(u'When  the update button is clicked')
def when_the_update_button_is_clicked(step):
    world.response = world.app.put('/api/foodcart/users/update/', data=json.dumps(world.user_updatedInfo))


"""Search User"""

@step(u'Given the entered keyword')
def given_the_entered_keyword(step):
    world.user_keyword = step.hashes[0]


@step(u'When  the search button is clicked')
def when_the_search_button_is_clicked(step):
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


"""Order"""
"""Adding Order"""

@step(u'Given I have the following order details:')
def order_details(step):
    world.order = step.hashes[0]


@step(u'When the user clicks the add button')
def when_the_user_clicks_the_add_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/orders/add/', data=json.dumps(world.order))




""" Common steps for jsonify response """


@step(u'Then  it should have a \'([^\']*)\' response')
def then_it_should_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And   it should have a field \'([^\']*)\' containing \'([^\']*)\'')
def and_it_should_get_a_field_group1_containing_group2(step, field, expected_value):
    world.response_json = json.loads(world.response.data)
    assert_equals(str(world.response_json[field]), expected_value)
