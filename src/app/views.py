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