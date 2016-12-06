import os
from flask import Flask, jsonify, request
from os import sys
from models import DBconn
import json, flask

from spcalls import SPcalls
from app import app

spcalls = SPcalls()


@app.route('/api/foodcart/restaurants/', methods=['POST'])
def store_restaurant():
    data = json.loads(request.data)

    resto_name = data['resto_name']
    min_order = data['min_order']
    delivery_fee = data['delivery_fee']
    location = data['location']

    if (resto_name == '' or not min_order or not delivery_fee or location == ''):

        return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

    else:

        restaurant = spcalls.spcall('store_restaurant', (resto_name, min_order, delivery_fee, location), True)

        if 'Error' in str(restaurant[0][0]):
            return jsonify({"status": "FAILED", "message": restaurant[0][0]})

        else:
            return jsonify({"status": "OK", "message": restaurant[0][0]})


# Users

@app.route('/api/foodcart/orders/add/', methods=['POST'])
def store_order():
    data = json.loads(request.data)

    if (not data['role_id'] or not data['payment_id'] or not data['order_foods_id']):

        return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

    else:
        order = spcalls.spcall('store_order', (
            data['role_id'], data['payment_id'], data['order_foods_id']), True)

        if 'Error' in str(order[0][0]):
            return jsonify({"status": "error", "message": order[0][0]})

        return jsonify({"status": "OK", "message": order[0][0]})


@app.route('/api/foodcart/users/', methods=['GET'])
def get_users():
    user = spcalls.spcall('get_all_user', ())
    entries = []

    if 'Error' in str(user[0][0]):
        return jsonify({"status": "FAILED", "message": user[0][0]})

    elif len(user) != 0:
        for r in user:
            entries.append(
                {'id': str(r[0]), 'fname': str(r[1]), 'mname': str(r[2]), 'lname': str(r[3]), 'address': str(r[4]),
                 'email': str(r[5]), 'mobile_number': str(r[6]), 'role_id': str(r[8]), 'earned_points': str(r[9])})

        return jsonify({"status": "OK", "message": "OK", "entries": entries, "count": len(entries)})

    else:
        return jsonify({"status": "FAILED", "message": "No User Found", "entries": []})


@app.route('/api/foodcart/users/<int:id>/', methods=['GET'])
def get_user(id):
    user = spcalls.spcall('show_user', (id,))
    entries = []

    if len(user) == 0:
        return jsonify({"status": "FAILED", "message": "No User Found", "entries": []})

    elif 'Error' in str(user[0][0]):
        return jsonify({"status": "FAILED", "message": user[0][0]})

    else:
        r = user[0]
        entries.append({'id': str(id), 'fname': str(r[0]), 'mname': str(r[1]), 'lname': str(r[2]), 'address': str(r[3]),
             'email': str(r[4]), 'mobile_number': str(r[5]), 'role_id': str(r[7]), 'earned_points': str(r[8])})

        return jsonify({"status": "OK", "message": "OK", "entries": entries})


@app.route('/api/foodcart/users/update/', methods=['PUT'])
def update():
    jsn = json.loads(request.data)

    id_personnel = jsn.get('id', '')
    fname = jsn.get('fname', '')
    mname = jsn.get('mname', '')
    lname = jsn.get('lname', '')
    address = jsn.get('address', '')
    email = jsn.get('email', '')
    mobile_number = jsn.get('mobile_number', '')
    user_password = jsn.get('user_password', '')
    role_id = jsn.get('role_id', '')
    earned_points = jsn.get('earned_points', '')

    spcalls.spcall('update_user', (
        id_personnel,
        fname,
        mname,
        lname,
        address,
        email,
        mobile_number,
        user_password,
        role_id,
        earned_points
    ), True)

    return jsonify({'status': 'OK'})


@app.route('/api/foodcart/users/search/', methods=['POST'])
def search_user():
    data = json.loads(request.data)

    keyword = data['search']

    users = spcalls.spcall('search_user', (keyword,))
    entries = []


    if users:
        for r in users:
            if r[7] == True:
                entries.append({"fname": r[0], "mname": r[1], "lname": r[2], "address": r[3],
                                "email": r[4], "mobile_number": r[5], "role_id": r[6], "earned_points": r[7]})

        return jsonify({'status': 'OK', 'message': 'OK', 'entries': entries})

    return jsonify({'status': 'FAILED', 'message': 'No data matched your search'})


@app.route('/api/foodcart/users/deactivate/<id>/', methods = ['PUT'])
def deactivate_user(id):
    restaurant = spcalls.spcall('deactivate_user', (id,), True)

    return jsonify({"status": "OK", "message": restaurant[0][0]})


@app.route('/api/foodcart/restaurants/', methods = ['GET'])
def get_restaurants():
    restaurant = spcalls.spcall('show_all_restaurant', ())
    entries = []
    
    if 'Error' in str(restaurant[0][0]):
        return jsonify({"status": "FAILED", "message": restaurant[0][0]})

    elif len(restaurant) != 0:
        for r in restaurant:
            entries.append({"restaurant_id": r[0],
                            "restaurant_name": r[1],
                            "minimum_order": r[2],
                            "delivery_fee": r[3],
                            "location": r[4],
                            "is_active": r[5]})

        return jsonify({"status": "OK", "message": "OK", "entries": entries, "count": len(entries)})

    else:
        return jsonify({"status": "FAILED", "message": "No Restaurant Found", "entries": []})


@app.route('/api/foodcart/restaurants/<int:resto_id>', methods = ['GET'])
def get_restaurant(resto_id):
    restaurant = spcalls.spcall('show_restaurant', (resto_id,))
    entries = []
    

    if len(restaurant) == 0:
        return jsonify({"status": "FAILED", "message": "No Restaurant Found", "entries": []})
    
    elif 'Error' in str(restaurant[0][0]):
        return jsonify({"status": "FAILED", "message": restaurant[0][0]})

    else:

        r = restaurant[0]

        entries.append({"restaurant_id": r[0],
                        "restaurant_name": r[1],
                        "minimum_order": r[2],
                        "delivery_fee": r[3],
                        "location": r[4],
                        "is_active": r[5]})

        return jsonify({"status": "OK", "message": "OK", "entries": entries})


@app.route('/api/foodcart/orders/add/', methods=['POST'])
def add_order():
    data = json.loads(request.data)


    if (not role_id or not payment_id or not order_food_id):

        return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

    else:

        restaurant = spcalls.spcall('store_restaurant', (resto_name, min_order, delivery_fee, location), True)

        if 'Error' in str(restaurant[0][0]):
            return jsonify({"status": "FAILED", "message": restaurant[0][0]})

        else:
            return jsonify({"status": "OK", "message": restaurant[0][0]})



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
