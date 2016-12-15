import json
from app import *
from models import DBconn
from flask import request
import re
import hashlib
from flask import jsonify
from spcalls import SPcalls


spcalls = SPcalls()


def store_food(data):

    food_name = data['food_name']
    description = data['description']
    unit_cost = data['unit_cost']
    image_url = data['image_url']
    resto_id = data['resto_id']


    if (food_name == '' or description == '' or not unit_cost):
        return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

    else:

        food = spcalls.spcall('store_food', (food_name, description, unit_cost, resto_id), True)

        if 'Error' in str(food[0][0]):
            return jsonify({"status": "FAILED", "message": food[0][0]})

        else:
            food_id  = food[0][0]

            if (food_id == 0):
                return jsonify({"status": "FAILED", "message": "EXISTED"})

            elif 'Error' in str(food[0][0]):
                return jsonify({"status": "FAILED", "message": food[0][0]})

            else:
                image = spcalls.spcall('update_food_image', (food_id, image_url), True)

                if 'Error' in str(image[0][0]):
                    return jsonify({"status": "FAILED", "message": image[0][0]})

                else:
                    return jsonify({"status": "OK", "message": "OK"})


def show_foods(resto_id):
    foods = spcalls.spcall('show_foods', (resto_id, ))
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
                                "is_available": f[4],
                                "is_active": f[5],
                                "image_url": f[6]})

        return jsonify({"status": "OK", "message": "OK", "entries": entries, "count": len(entries)})

    else:
        return jsonify({"status": "FAILED", "message": "No food found", "entries": []})