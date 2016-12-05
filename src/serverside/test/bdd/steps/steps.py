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

@step(u'When  the view button is clicked')
def when_the_view_button_is_clicked(step):
    world.response = world.app.get('/api/foodcart/restaurants/{}'.format(world.resto_id))    


""" Update Restaurant """

@step(u'And the old details of the restuarant')
def and_the_old_details_of_the_restuarant(step):
    world.restaurant_oldInfo = step.hashes[0]

@step(u'And the new details of retaurant')
def and_the_new_details_of_retaurant(step):
    world.restaurant_updatedInfo = step.hashes[0]

@step(u'When  the update button is clicked')
def when_the_update_button_is_clicked(step):
    world.response = world.app.put('/api/foodcart/restaurants/1', data=json.dumps(world.restaurant_updatedInfo))


""" Deactivate Restaurant """

@step(u'Given the restaurant id \'([^\']*)\' is in the database')
def given_the_restaurant_id_group1_is_in_the_database(step, resto_id):
    world.resto_id = resto_id

@step(u'When  the deactivate button is clicked')
def when_the_deactivate_button_is_clicked(step):
    world.browser = TestApp(app)
    world.response = world.app.put('/api/foodcart/restaurants/deactivate/{}'.format(world.resto_id))


""" Search Restaurant """

@step(u'Given the entered keyword')
def given_the_entered_keyword(step):
    world.restaurant_keyword = step.hashes[0]


@step(u'When  the search button is clicked')
def when_the_search_button_is_clicked(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/restaurants/search/', data=json.dumps(world.restaurant_keyword))




""" Steps for Food feature """

""" Add Food """

@step(u'Given following food details:')
def given_following_food_details(step):
    world.restaurant = step.hashes[0]

@step(u'When  add button is clicked')
def when_add_button_is_clicked(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/foodcart/foods/', data=json.dumps(world.restaurant))