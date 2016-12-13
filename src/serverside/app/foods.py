import json
from app import *
from models import DBconn
from flask import request
import re
import hashlib
from flask import jsonify
from spcalls import SPcalls


def store_food(data):

    food_name = data['food_name']
    description = data['description']
    unit_cost = data['unit_cost']
    resto_branch_id = data['resto_branch_id']


    if (food_name == '' or description == '' or not unit_cost):
        return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

    else:

        food = spcalls.spcall('update_food_image', (food_id, food_name, description, unit_cost, resto_branch_id), True)

        if 'Error' in str(food[0][0]):
            return jsonify({"status": "FAILED", "message": food[0][0]})

        else:

            return jsonify({"status": "OK", "message": food[0][0]})