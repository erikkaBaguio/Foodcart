import os
from flask import Flask, jsonify, request
from os import sys
from models import DBconn
import json, flask

from spcalls import SPcalls
from app import app

spcalls = SPcalls()


@app.route('/api/foodcart/restaurants/', methods = ['POST'])
def store_restaurant():
	data = json.loads(request.data)

	resto_name = data['resto_name']
	min_order = data['min_order']
	delivery_fee = data['delivery_fee']
	location = data['location']

	if ( resto_name == '' or not min_order or not delivery_fee or location == '' ):
	
		return jsonify({"status": "FAILED", "message": "Please fill the required fields"})
	
	else:
	
		restaurant = spcalls.spcall('store_restaurant',(resto_name, min_order, delivery_fee, location),True)
		
		if 'Error' in str(restaurant[0][0]):
			return jsonify({"status": "FAILED", "message": restaurant[0][0]})

		else:
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