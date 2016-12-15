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


def get_transaction_id(id):
    transaction = spcalls.spcall('show_transaction_id', (id,))
    entries = []

    if len(transaction) == 0:
        return jsonify({"status": "FAILED", "message": "No Transaction Found", "entries": []})

    elif 'Error' in str(transaction[0][0]):
        return jsonify({"status": "FAILED", "message": transaction[0][0]})

    else:
        r = transaction[0]
        entries.append(
            {'id': str(id), 'transaction_number': str(r[0]), 'transaction_date': str(r[1]), 'order_id': str(r[2]),
             'total': str(r[3]), 'bldg_number': str(r[4]), 'street': str(r[5]), 'room_number': str(r[6]), 'is_paid': str(r[7])})

        return jsonify({"status": "OK", "message": "OK", "entries": entries})


def show_all_transactions():
    transaction = spcalls.spcall('show_transaction', ())
    entries = []

    if 'Error' in str(transaction[0][0]):
        return jsonify({"status": "FAILED", "message": transaction[0][0]})

    elif len(transaction) != 0:
        for r in transaction:
            entries.append(
                {'id': str(id), 'transaction_number': str(r[0]), 'transaction_date': str(r[1]), 'order_id': str(r[2]),
                 'total': str(r[3]), 'bldg_number': str(r[4]), 'street': str(r[5]), 'room_number': str(r[6]),
                 'is_paid': str(r[7])})
        return jsonify({"status": "OK", "message": "OK", "entries": entries, "count": len(entries)})

    else:
        return jsonify({"status": "FAILED", "message": "No Transaction Found", "entries": []})
