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


"""Add new user"""

@step(u'Given I have the following user details:')
def user_details(step):
    world.user = step.hashes[0]

@step(u'When  the user clicks the send button')
def when_the_user_clicks_the_send_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/users/signup/', data = json.dumps(world.user))



""" Common steps for jsonify response """


@step(u'Then  it should have a \'([^\']*)\' response')
def then_it_should_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And   it should have a field \'([^\']*)\' containing \'([^\']*)\'')
def and_it_should_get_a_field_group1_containing_group2(step, field, expected_value):
    world.response_json = json.loads(world.response.data)
    assert_equals(str(world.response_json[field]), expected_value)

