import json
from app import *
from models import DBconn
from flask import request
import re
import hashlib
from flask import jsonify
from spcalls import SPcalls


spcalls = SPcalls()


def new_transaction(data):
    transaction_number = data['transaction_number']
    order_id = data['order_id']
    total = data['total']
    bldg_number = data['bldg_number']
    street = data['street']
    room_number = data['room_number']

    if (not transaction_number or not order_id or total == '' or bldg_number == '' or street == '' or room_number == ''):
        return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

    else:
        transaction = spcalls.spcall('add_transaction', (transaction_number, order_id, total), True)

        if 'Error' in str(transaction[0][0]):
            return jsonify({"status": "FAILED", "message": transaction[0][0]})

        else:
            transaction_id = transaction[0][0]

            address_id = spcalls.spcall('update_trans_address', (transaction_id, bldg_number, street, room_number), True)

            if 'Error' in str(address_id[0][0]):
                return jsonify({"status": "FAILED", "message": address_id[0][0]})

            else:
                return jsonify({"status": "OK", "message": address_id[0][0]})

        return jsonify({"status": "OK", "message": transaction[0][0]})
