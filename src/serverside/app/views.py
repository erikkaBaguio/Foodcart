import os
from flask import Flask, jsonify, request
from os import sys
from models import DBconn
import json, flask
from spcalls import SPcalls
from restaurants import *
from app import app

spcalls = SPcalls()


@app.route('/api/foodcart/restaurants/', methods=['POST'])
def add_restaurant():
    data = json.loads(request.data)

    response = store_restaurant(data)

    return response


@app.route('/api/foodcart/restaurants/', methods=['GET'])
def get_restaurants():
    response = show_all_restaurants()

    return response


@app.route('/api/foodcart/restaurants/<resto_id>', methods=['GET'])
def get_restaurant(resto_id):
    response =  show_rastaurant(resto_id)

    return response


@app.route('/api/foodcart/restaurants/<restaurant_id>', methods=['PUT'])
def update_restaurant(restaurant_id):
    data = json.loads(request.data)

    resto_name = data['resto_name']
    min_order = data['min_order']
    delivery_fee = data['delivery_fee']
    location = data['location']

    if (resto_name == '' or not min_order or not delivery_fee or location == ''):

        return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

    else:

        restaurant = spcalls.spcall('update_restaurant', (restaurant_id, resto_name, min_order, delivery_fee, location),
                                    True)

        if 'Error' in str(restaurant[0][0]):
            return jsonify({"status": "FAILED", "message": restaurant[0][0]})

        else:
            return jsonify({"status": "OK", "message": restaurant[0][0]})


@app.route('/api/foodcart/restaurants/deactivate/<resto_id>', methods=['PUT'])
def deactivate_restaurant(resto_id):
    restaurant = spcalls.spcall('delete_restaurant', (resto_id,), True)

    return jsonify({"status": "OK", "message": restaurant[0][0]})


@app.route('/api/foodcart/restaurants/search/', methods=['POST'])
def search_restaurant():
    data = json.loads(request.data)

    search_keyword = data['search']

    restaurants = spcalls.spcall('search_restaurant', (search_keyword,), True)
    entries = []

    if restaurants:
        for r in restaurants:
            if r[5] == True:
                entries.append({"restaurant_id": r[0],
                                "restaurant_name": r[1],
                                "minimum_order": r[2],
                                "delivery_fee": r[3],
                                "location": r[4],
                                "is_active": r[5]})

        return jsonify({"status": "OK", "message": "OK", "entries": entries, "count": len(entries)})

    return jsonify({"status": "FAILED", "message": "No Restaurant Found", "entries": []})


#############
#   FOOD    #
#############

@app.route('/api/foodcart/foods/', methods=['POST'])
def store_food():
    data = json.loads(request.data)

    food_name = data['food_name']
    description = data['description']
    unit_cost = data['unit_cost']

    if (food_name == '' or description == '' or not unit_cost):
        return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

    else:

        food = spcalls.spcall('store_food', (food_name, description, unit_cost,), True)

        if 'Error' in str(food[0][0]):
            return jsonify({"status": "FAILED", "message": food[0][0]})

        else:
            return jsonify({"status": "OK", "message": food[0][0]})


@app.route('/api/foodcart/foods/', methods=['GET'])
def get_foods():
    foods = spcalls.spcall('show_all_food', ())
    entries = []

    if 'Error' in str(foods[0][0]):
        return jsonify({"status": "FAILED", "message": foods[0][0]})

    elif len(foods) != 0:
        for f in foods:
            if f[4] == True:
                entries.append({"food_id": f[0],
                                "food_name": f[1],
                                "description": f[2],
                                "unit_cost": f[3],
                                "is_active": f[4]})

        return jsonify({"status": "OK", "message": "OK", "entries": entries, "count": len(entries)})

    else:
        return jsonify({"status": "FAILED", "message": "No food found", "entries": []})


@app.route('/api/foodcart/foods/<food_id>', methods=['GET'])
def get_food(food_id):
    food = spcalls.spcall('show_food', (food_id,))
    entries = []

    if len(food) == 0:
        return jsonify({"status": "FAILED", "message": "No food found", "entries": []})

    elif 'Error' in str(food[0][0]):
        return jsonify({"status": "FAILED", "message": food[0][0]})

    else:
        f = food[0]

        entries.append({"food_id": f[0],
                        "food_name": f[1],
                        "description": f[2],
                        "unit_cost": f[3],
                        "is_active": f[4]})

        return jsonify({"status": "OK", "message": "OK", "entries": entries, "count": len(entries)})


@app.route('/api/foodcart/foods/<food_id>', methods=['PUT'])
def update_food(food_id):
    data = json.loads(request.data)

    food_name = data['food_name']
    description = data['description']
    unit_cost = data['unit_cost']

    if (food_name == '' or description == '' or not unit_cost):
        return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

    else:

        food = spcalls.spcall('update_food', (food_id, food_name, description, unit_cost,), True)

        if 'Error' in str(food[0][0]):
            return jsonify({"status": "FAILED", "message": food[0][0]})

        else:
            return jsonify({"status": "OK", "message": food[0][0]})


@app.route('/api/foodcart/foods/deactivate/<food_id>', methods=['PUT'])
def deactivate_food(food_id):
    food = spcalls.spcall('delete_food', (food_id,), True)

    return jsonify({"status": "OK", "message": food[0][0]})


@app.route('/api/foodcart/foods/search/', methods=['POST'])
def search_food():
    data = json.loads(request.data)

    search_keyword = data['search']

    foods = spcalls.spcall('search_food', (search_keyword,), True)
    entries = []

    if foods:
        for f in foods:

            if f[4] == True:
                entries.append({"food_id": f[0],
                                "food_name": f[1],
                                "description": f[2],
                                "unit_cost": f[3],
                                "is_active": f[4]})
            return jsonify({"status": "OK", "message": "OK", "entries": entries, "count": len(entries)})

    return jsonify({"status": "FAILED", "message": "No results found", "entries": []})


@app.after_request
def add_cors(resp):
    resp.headers['Access-Control-Allow-Origin'] = flask.request.headers.get('Origin', '*')
    resp.headers['Access-Control-Allow-Credentials'] = True
    resp.headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS, GET, PUT, DELETE'
    resp.headers['Access-Control-Allow-Headers'] = flask.request.headers.get('Access-Control-Request-Headers',
                                                                             'Authorization')
    # set low for debugging
    if app.debug:
        resp.headers["Access-Control-Max-Age"] = '1'
    return resp