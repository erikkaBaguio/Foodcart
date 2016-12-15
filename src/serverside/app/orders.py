import json
from app import *
from models import DBconn
from flask import request
import re
import hashlib
from flask import jsonify
from spcalls import SPcalls


spcalls = SPcalls()


def store_order(data):
    user_id = data['user_id']
    quantity = data['quantity']
    food_id = data['food_id']
    resto_branch_id = data['resto_branch_id']


    if (not user_id or not quantity or not food_id or not resto_branch_id):
        return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

    else:
        order = spcalls.spcall('add_order', (user_id), True)

        if 'Error' in str(order[0][0]):
            return jsonify({"status": "FAILED", "message": order[0][0]})

        else:
            order_id  = order[0][0]

            order_food_id = spcalls.spcall('update_orderfoodID', (order_id, quantity, food_id, resto_branch_id), True)

            if 'Error' in str(order_food_id[0][0]):
                return jsonify({"status": "FAILED", "message": order_food_id[0][0]})

            else:
                return jsonify({"status": "OK", "message": order_food_id[0][0]})

        return jsonify({"status": "OK", "message": order[0][0]})
