import json
# from app import *
from models import DBconn
from flask import request
import re
import hashlib
from flask import jsonify
from spcalls import SPcalls


spcalls = SPcalls()


def store_user(data):
    email = data['user_email']

    check_email_exist = spcalls.spcall('check_email', (email,))

    if check_email_exist[0][0] == 'OK':

        check_email = re.match('^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$', email)

        if check_email is not None:
            fname = data['fname']
            mname = data['mname']
            lname = data['lname']
            password = data['user_password']
            role_id = data['role_id']
            email = data['user_email']
            tel_number = data['user_tel_number']
            mobile_number = data['user_mobile_number']
            bldg_number = data['user_bldg_number']
            street = data['user_street']
            room_number = data['user_room_number']

            complete_fields = fname is not '' and mname is not '' and lname is not '' and password is not '' and role_id is not '' and email is not '' and tel_number is not '' and mobile_number is not '' and bldg_number is not '' and street is not '' and room_number is not ''

            if complete_fields is True:
                pw_hash = hashlib.md5(password.encode())

                user = spcalls.spcall('store_user', (
                    data['fname'], data['mname'], data['lname'], pw_hash.hexdigest(), data['role_id']), True)

                if 'Error' in str(user[0][0]):
                    return jsonify({"status": "error", "message": user[0][0]})

                else:
                    user_id = user[0][0]

                    contact = spcalls.spcall('update_user_contact', (user_id, data['user_email'], data['user_tel_number'], data['user_mobile_number']), True)
                    address = spcalls.spcall('update_user_address', (user_id, data['user_bldg_number'], data['user_street'], data['user_room_number']), True)

                    if 'Error' in str(contact[0][0]):
                        return jsonify({"status": "FAILED", "message": contact[0][0]})

                    elif 'Error' in str(address[0][0]):
                        return jsonify({"status": "FAILED", "message": address[0][0]})

                    else:
                        return jsonify({"status": "OK", "message": user[0][0]})

            elif complete_fields is False:
                return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

        else:
            return jsonify({'status': 'FAILED', 'message': 'Invalid email input!'})

    elif check_email_exist[0][0] == 'ALREADY EXISTS':
        return jsonify({'status': 'FAILED', 'message': 'Email already exists'})

    else:
        return jsonify({"status": "FAILED"})


def get_user_id(id):
    user = spcalls.spcall('show_user_id', (id,))
    entries = []

    if len(user) == 0:
        return jsonify({"status": "FAILED", "message": "No User Found", "entries": []})

    elif 'Error' in str(user[0][0]):
        return jsonify({"status": "FAILED", "message": user[0][0]})

    else:
        r = user[0]
        entries.append(
            {'id': str(id), 'fname': str(r[0]), 'mname': str(r[1]), 'lname': str(r[2]), 'earned_points': str(r[4]),
             'email': str(r[8]), 'tel_number': str(r[9]), 'mobile_number': str(r[10]), 'bldg_number': str(r[11]),
             'street': str(r[12]), 'room_number': str(r[13]), 'role_id': str(r[7])})

        return jsonify({"status": "OK", "message": "OK", "entries": entries})


def show_all_users():
    user = spcalls.spcall('show_user', ())
    entries = []

    if 'Error' in str(user[0][0]):
        return jsonify({"status": "FAILED", "message": user[0][0]})

    elif len(user) != 0:
        for r in user:
            entries.append({'id': str(r[0]), 'fname': str(r[1]), 'mname': str(r[2]), 'lname': str(r[3]),
                            'earned_points': str(r[5]),
                            'email': str(r[9]), 'tel_number': str(r[10]), 'mobile_number': str(r[11]),
                            'bldg_number': str(r[12]),
                            'street': str(r[13]), 'room_number': str(r[14]), 'role_id': str(r[8])})

        return jsonify({"status": "OK", "message": "OK", "entries": entries, "count": len(entries)})

    else:
        return jsonify({"status": "FAILED", "message": "No User Found", "entries": []})



def delete_user(id):
    user = spcalls.spcall('deactivate_user', (id,), True)

    return jsonify({"status": "OK", "message": user[0][0]})