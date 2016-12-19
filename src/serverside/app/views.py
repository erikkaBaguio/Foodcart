import os
from flask import Flask, jsonify, request
from os import sys
from models import DBconn
import json, flask
import hashlib
from flask.ext.httpauth import HTTPBasicAuth
from datetime import timedelta
from itsdangerous import URLSafeTimedSerializer
from spcalls import SPcalls
from restaurants import *
from foods import *
from users import *
from orders import *
from transactions import *
from app import app

SECRET_KEY = "a_random_secret_key_$%#!@"
auth = HTTPBasicAuth()
spcalls = SPcalls()

login_serializer = URLSafeTimedSerializer(SECRET_KEY)


# Users
def get_auth_token(email, password):
    """
    Encode a secure token for cookie
    """
    data = [email, password]
    return login_serializer.dumps(data)


def load_token(token):
    """
    The Token was encrypted using itsdangerous.URLSafeTimedSerializer which
    allows us to have a max_age on the token itself.  When the cookie is stored
    on the users computer it also has a exipry date, but could be changed by
    the user, so this feature allows us to enforce the exipry date of the token
    server side and not rely on the users cookie to exipre.
    source: http://thecircuitnerd.com/flask-login-tokens/
    """
    days = timedelta(days=14)
    max_age = days.total_seconds()

    # Decrypt the Security Token, data = [username, hashpass]
    data = login_serializer.loads(token, max_age=max_age)

    return data[0] + ':' + data[1]


def get_password(email):
    spcall = SPcalls()
    return spcalls.spcall("get_password", (email,))[0][0]


@app.route('/decrypt', methods=['POST'])
def decr():
    credentials = json.loads(request.data)
    token = credentials['token']

    return jsonify({'status': 'OK', 'token': load_token(token)})


@app.route('/api/foodcart/users/login/', methods=['POST'])
def authentication():
    data = json.loads(request.data)
    email = data['email_add']
    password = data['password']

    pw_hash = hashlib.md5(password.encode())

    spcall = SPcalls()

    login = spcalls.spcall('check_email_password', (email, pw_hash.hexdigest()))

    if not email or not password:
        return jsonify ({'status': 'FAILED', 'message': 'Invalid email or password'})

    if login[0][0] == 'FAILED':
        return jsonify ({'status': 'FAILED', 'message': 'Invalid email or password'})

    if login[0][0] == 'OK':
        user = spcalls.spcall('show_user_email', (email,))
        entry = []

        for u in user:
            entry.append({'fname': u[1], 'mname': u[2], 'lname': u[3], 'email': u[10], 'role': u[8]})

        token = get_auth_token(email, pw_hash.hexdigest())

        return jsonify({'status': 'OK', 'message': 'Successfully logged in', 'token': token, 'data': entry})

    else:
        return jsonify({'status': 'ERROR', 'message': '404'})



@app.route('/api/foodcart/home/<string:token>', methods=['GET'])
def index(token):
    days = timedelta(days=14)
    max_age = days.total_seconds()

    # Decrypt the Security Token, data = [username, hashpass]
    email = login_serializer.loads(token, max_age=max_age)

    user = spcalls.spcall('show_user_email', (email,))
    entry = []

    for u in user:
        entry.append({'fname': u[1], 'mname': u[2], 'lname': u[3], 'email': u[10], 'role': u[8]})

    return jsonify({'status': 'OK', 'message': 'Welcome user', 'data': entry})



@app.route('/api/foodcart/users/signup/', methods=['POST'])
def store_new_user():
    data = json.loads(request.data)

    response = store_user(data)

    return response


@app.route('/api/foodcart/users/<int:id>/', methods=['GET'])
def show_user_id(id):

    response = get_user_id(id)

    return response


@app.route('/api/foodcart/users/', methods=['GET'])
def show_user():

    response = show_all_users()

    return response


@app.route('/api/foodcart/users/update/<user_id>/', methods=['PUT'])
def update_user(user_id):
    data = json.loads(request.data)

    fname = data['update_fname']
    mname = data['update_mname']
    lname = data['update_lname']
    user_password = data['update_user_password']
    earned_points = data['update_earned_points']

    if (fname == '' or mname == '' or lname == '' or user_password == ''):

        return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

    else:
        user = spcalls.spcall('update_user', (user_id, fname, mname, lname, user_password, earned_points), True)

        if 'Error' in str(user[0][0]):
            return jsonify({"status": "FAILED", "message": user[0][0]})

        else:
            return jsonify({"status": "OK", "message": user[0][0]})


@app.route('/api/foodcart/users/deactivate/<id>/', methods = ['PUT'])
def deactivate_user(id):

    response = delete_user(id)

    return response


@app.route('/api/foodcart/users/search/', methods=['POST'])
def search_user():
    data = json.loads(request.data)

    keyword = data['search']

    users = spcalls.spcall('search_user', (keyword,), True)
    entries = []


    if users:
        for r in users:
                entries.append({"fname": r[0], "mname": r[1], "lname": r[2], "earned_points": r[3],
                                "role_id": r[4], "email": r[5], "tel_number": r[6], "mobile_number": r[7], "bldg_number": r[8],
                                "street": r[9], "room_number": r[10]})

        return jsonify({'status': 'OK', 'message': 'OK', 'entries': entries, "count": len(entries)})

    return jsonify({'status': 'FAILED', 'message': 'No data matched your search', "entries": []})



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

    response = update_restaurant_branch(data, restaurant_id)

    return response


@app.route('/api/foodcart/restaurants/deactivate/<resto_id>', methods=['PUT'])
def deactivate_restaurant(resto_id):
    response = delete_restaurant(resto_id)

    return response


@app.route('/api/foodcart/restaurants/search/', methods=['POST'])
def search_restaurant():
    data = json.loads(request.data)
    response = search_resto(data)

    return response


#############
#   FOOD    #
#############

@app.route('/api/foodcart/foods/', methods=['POST'])
def add_food():
    data = json.loads(request.data)
    response = store_food(data)

    return response


@app.route('/api/foodcart/foods/<resto_id>', methods=['GET'])
def get_foods(resto_id):
    response = show_foods(resto_id)

    return response


@app.route('/api/foodcart/foods/<resto_id>/<food_id>', methods=['GET'])
def get_food(resto_id,food_id):
    response = show_food(resto_id, food_id)

    return response


@app.route('/api/foodcart/foods/<food_id>', methods=['PUT'])
def update_food(food_id):
    data = json.loads(request.data)

    response = food_update(data, food_id)

    return response


@app.route('/api/foodcart/foods/deactivate/<food_id>', methods=['PUT'])
def deactivate_food(food_id):
    food = spcalls.spcall('delete_food', (food_id,), True)

    return jsonify({"status": "OK", "message": food[0][0]})


@app.route('/api/foodcart/foods/search/', methods=['POST'])
def search_food():
    data = json.loads(request.data)

    response = food_search(data)
    return response


###############
#   ORDERS    #
###############

@app.route('/api/foodcart/orders/add/', methods=['POST'])
def add_order():
    data = json.loads(request.data)
    response = store_order(data)

    return response


@app.route('/api/foodcart/orders/<id>/', methods=['GET'])
def get_orderID(id):
    response = get_order_id(id)

    return response


@app.route('/api/foodcart/orders/', methods=['GET'])
def show_orders():

    response = show_all_orders()

    return response


################
# TRANSACTIONS #
################

@app.route('/api/foodcart/transactions/add/', methods=['POST'])
def add_transaction():
    data = json.loads(request.data)
    response = new_transaction(data)

    return response


@app.route('/api/foodcart/transactions/<id>/', methods=['GET'])
def get_transID(id):
    response = get_transaction_id(id)

    return response


@app.route('/api/foodcart/transactions/', methods=['GET'])
def show_transactions():

    response = show_all_transactions()

    return response




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