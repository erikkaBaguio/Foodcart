import json
# from app import *
from models import DBconn
from flask import request
import re
import hashlib
from flask import jsonify
from spcalls import SPcalls

spcalls = SPcalls()


def check_restaurant_branch(bldg_number, street, room_number, restoID):
    check_response = spcalls.spcall('check_restaurant_branch', (bldg_number, street, room_number, restoID,))

    return check_response[0][0]


def get_restaurant_id(resto_branch_id):
    response = spcalls.spcall('get_restaurant_id', (resto_branch_id,))

    return response[0][0]


def store_restaurant(data):
    resto_name = data['resto_name']
    min_order = data['min_order']
    delivery_fee = data['delivery_fee']
    image_url = data['image_url']
    email = data['email']
    tel_number = data['tel_number']
    mobile_number = data['mobile_number']
    bldg_number = data['bldg_number']
    street = data['street']
    room_number = data['room_number']

    if (resto_name == '' or image_url == '' or email == '' or tel_number == '' or mobile_number == '' or street == ''):

        return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

    else:

        restaurant = spcalls.spcall('store_restaurant', (resto_name, min_order), True)

        if 'Error' in str(restaurant[0][0]):
            return jsonify({"status": "FAILED", "message": restaurant[0][0]})

        else:
            resto_id = restaurant[0][0]

            print check_restaurant_branch(bldg_number, street, room_number, resto_id)

            image = spcalls.spcall('update_resto_image', (resto_id, image_url), True)

            if (check_restaurant_branch(bldg_number, street, room_number, resto_id) == False):

                restaurant_branch = spcalls.spcall('store_restaurant_branch', (resto_id, delivery_fee,), True)

                if 'Error' in str(restaurant_branch[0][0]):
                    return jsonify({"status": "FAILED", "message": restaurant_branch[0][0]})

                else:
                    contact = spcalls.spcall('update_resto_branch_contact',
                                             (resto_id, email, tel_number, mobile_number), True)
                    address = spcalls.spcall('update_resto_branch_address',
                                             (resto_id, bldg_number, street, room_number), True)

                    if 'Error' in str(contact[0][0]):
                        return jsonify({"status": "FAILED", "message": contact[0][0]})

                    elif 'Error' in str(address[0][0]):
                        return jsonify({"status": "FAILED", "message": address[0][0]})

                    else:
                        return jsonify({"status": "OK", "message": "OK"})

            else:
                return jsonify({"status": "FAILED", "message": "Restaurant branch already exists."})


def show_rastaurant(resto_id):
    restaurant = spcalls.spcall('show_restaurant_branch', (resto_id,))
    entries = []

    if len(restaurant) == 0:
        return jsonify({"status": "FAILED", "message": "No Restaurant Found", "entries": []})

    elif 'Error' in str(restaurant[0][0]):
        return jsonify({"status": "FAILED", "message": restaurant[0][0]})

    else:

        r = restaurant[0]

        entries.append({"restaurant_id": resto_id,
                        "restaurant_name": r[0],
                        "delivery_fee": r[1],
                        "minimum_order": r[2],
                        "email": r[3],
                        "tel_number": r[4],
                        "mobile_number": r[5],
                        "bldg_number": r[6],
                        "street": r[7],
                        "room_number": r[8],
                        "image_url": r[9],
                        "is_active": r[10]})

        return jsonify({"status": "OK", "message": "OK", "entries": entries})


def show_all_restaurants():
    restaurant = spcalls.spcall('show_all_restaurant_branch', ())
    entries = []

    if 'Error' in str(restaurant[0][0]):
        return jsonify({"status": "FAILED", "message": restaurant[0][0]})

    elif len(restaurant) != 0:
        for r in restaurant:
            entries.append({"restaurant_id": r[0],
                            "restaurant_name": r[1],
                            "delivery_fee": r[2],
                            "minimum_order": r[3],
                            "email": r[4],
                            "tel_number": r[5],
                            "mobile_number": r[6],
                            "bldg_number": r[7],
                            "street": r[8],
                            "room_number": r[9],
                            "image_url": r[10],
                            "is_active": r[11]})

        return jsonify({"status": "OK", "message": "OK", "entries": entries, "count": len(entries)})

    else:
        return jsonify({"status": "FAILED", "message": "No Restaurant Found", "entries": []})


def update_restaurant_branch(data, resto_branch_id):
    resto_name = data['resto_name']
    min_order = data['min_order']
    delivery_fee = data['delivery_fee']
    image_url = data['image_url']
    email = data['email']
    tel_number = data['tel_number']
    mobile_number = data['mobile_number']
    bldg_number = data['bldg_number']
    street = data['street']
    room_number = data['room_number']

    if (resto_name == '' or image_url == '' or email == '' or tel_number == '' or mobile_number == '' or street == ''):

        return jsonify({"status": "FAILED", "message": "Please fill the required fields"})

    else:

        restaurant_branch = spcalls.spcall('update_restaurant_branch', (resto_branch_id, delivery_fee), True)
        contact = spcalls.spcall('update_resto_branch_contact', (resto_branch_id, email, tel_number, mobile_number),
                                 True)
        resto_id = get_restaurant_id(resto_branch_id)

        if 'Error' in str(restaurant_branch[0][0]):
            return jsonify({"status": "FAILED", "message": restaurant_branch[0][0]})

        elif 'Error' in str(contact[0][0]):
            return jsonify({"status": "FAILED", "message": contact[0][0]})
        else:

            restaurant = spcalls.spcall('update_restaurant', (resto_id, min_order), True)
            address = spcalls.spcall('update_resto_branch_address', (resto_branch_id, bldg_number, street, room_number),
                                     True)

            if 'Error' in str(restaurant[0][0]):
                return jsonify({"status": "FAILED", "message": restaurant[0][0]})

            elif 'Error' in str(address[0][0]):
                return jsonify({"status": "FAILED", "message": address[0][0]})

            else:
                return jsonify({"status": "OK", "message": "OK"})

            return jsonify({"status": "OK", "message": "OK"})


def delete_restaurant(resto_id):
    restaurant = spcalls.spcall('delete_restaurant_branch', (resto_id,), True)

    return jsonify({"status": "OK", "message": restaurant[0][0]})

def search_resto(data):
    search_keyword = data['search']

    restaurants = spcalls.spcall('search_restaurant', (search_keyword,), True)
    entries = []

    if restaurants:
        for r in restaurants:
                entries.append({"restaurant_id": r[0],
                                "restaurant_name": r[1],
                                "minimum_order": r[2],
                                "image_id": r[3]})

        return jsonify({"status": "OK", "message": "OK", "entries": entries, "count": len(entries)})

    return jsonify({"status": "FAILED", "message": "No data matched your search", "entries": []})