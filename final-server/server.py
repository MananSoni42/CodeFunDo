import datetime
from logger import log
from flask import Flask, request
from tinydb import TinyDB, Query
from predict import risk_eq, risk_fld
#from fcm_server import _send_fcm_message, _build_common_message

app = Flask(__name__)
db = TinyDB('database.json')
user = Query()

def get_score_num(lat,lon):
    return { "earthquake": risk_eq(lat,lon), "flood": risk_fld(lat, lon) }

def send_mail():
    #TODO
    pass

def get_token_list(lat,lon, radius=10):
    token_list = []
    for row in db:
        dist = (lat-row["latitude"])**2 + (lon-row["longitude"])**2
        if dist <= radius**2:
            token_list.append(row["token"])
    return token_list

def get_nearest_user(users,lat,lon):
    return users()
    return sorted(users, key = lambda x: (int(x[1])-lat)**2 + (int(x[2])-lon)**2)

def add(json_data):
    """
    add fields to database.json according to given json received
    fills with -999 if key is not found in json

    Also checks if a user has marked himself unsafe and takes
    required action
    """

    #create data row to store in database.csv
    date = datetime.datetime.now().strftime('%Y-%m-%d-%H-%M-%S')
    final_data = { "token": -999, "latitude": -999, "longitude": -999, "safe": -1, "num_donations": 0,
                   "amt_donated": 0, "date": date }

    for key in final_data.keys():
        if key in json_data:
            final_data[key] = json_data[key]
        else:
            pass

    if final_data["token"] == -999:
        log('-999','no token in POST request at /data')
        return ""

    elif db.search(user.token == final_data["token"]):
        if final_data["latitude"] == -999 or final_data["longitude"] == -999:
            final_data["latitude"] = db.search(user.token == final_data["token"])[0]["latitude"]
            final_data["longitude"] = db.search(user.token == final_data["token"])[0]["longitude"]
        db.update(final_data, user.token == final_data["token"])

    else:
        db.insert(final_data)

    log(final_data["token"],'received POST request at /data')

    if final_data["safe"] == 0:
        send_notif_safety(final_data["token"], final_data["latitude"],final_data["longitude"])
        suggest_safe_spots(final_data["token"])

    return ""

def send_notif_safety(self_token, lat, lon):
    """
    Send notification asking for nearby users' safety
    after a certain user marks himself unsafe
    """
    tokens = get_token_list(lat,lon)
    notif_data = {"notification": 1}
    for token in tokens:
        #probably build an override message with 2 buttons (Safe/Unsafe)
        if token != '-999' and token != self_token:
            log(token,'sent notif: mark safe/unsafe data: notif(button)')
            _send_fcm_message(_build_common_message(token=token,notif={"title": 'ARE YOU SAFE',"body": 'Please mark yourself as safe/unsafe'}, data=notif_data))

def send_notif_safe_spot(token, users):
    """
    Send notification notifying unsafe users about safe spots
    """
    title = "ALERT"
    body = f'We found {len(users)} Safe Spots near you!'

    loc_data = [(row["latitude"],row["longitude"]) for row in users]

    log(token, 'sent notf: safe spot, data: notif(buttons)')
    _send_fcm_message(_build_common_message(token,notif={"title": title, "body": body},data={"notifiation": 1, "location": loc_data }))


def send_notif_disaster():
    """
    if a major disaster is detected, notify all users that a disaster may be imminent
    """
    body_msg = 'There is a possibility of a Disaster in your area, please take all neccessary precautions'
    for row in db:
        if row["token"] != '-999':
            log(token, 'sent notif: disaster alert')
            _send_fcm_message(_build_common_message(token,notif={"title": 'High Alert', "body": body_msg}))

def suggest_safe_spots(token, radius=10):
    """
    given index of user in database,
    suggest safe spots for the user
    """

    if not db.search(user.token == str(token)):
        print('Invalid Token')
        return

    token_time = db.search(user.token == str(token))[0]["date"]
    lat = db.search(user.token == str(token))[0]["latitude"]
    lon = db.search(user.token == str(token))[0]["longitude"]

    near = lambda x: True if (x["latitude"]-lat)**2 + (x["longitude"]-long)**2 < radius**2 else False
    safe_users = []
    for row in db:
        if row["date"] > token_time and row["safe"] == "1" and row["token"] != '-999' and near(row):
            safe_users.append(row)

    if safe_users:
        send_notif_safe_spot(token,safe_users)

def disaster_detected(radius=10, threshold=42):
    """
    if too many people (> threshold) mark themselves unsafe within a radius,
    say that a disaster has occured
    """

    near = lambda x,y: True if (x["latitude"]-y["latitude"])**2 + (x["longitude"]-y["longitude"])**2 < radius**2 else False

    for row1 in db:
        count = 0
        for row2 in db:
            if row1["safe"] == 0 and row2["safe"] == 0 and near(row1,row2):
                count+=1
        if count >= threshold:
            return True
    return False

def disaster_prevent():
    """
    functions to prevent and control a disaster
    """
    send_notif_disaster()
    send_mail()

@app.route('/data', methods=['POST'])
def receive():
    """
    Accepts requests to /data endpoint
    saves relevant fields to database.csv
    """
    json_data = request.get_json()
    add(json_data)
    return ""

@app.route('/score', methods=['POST'])
def send_score():
    """
    Accepts requests to /score endpoint
    json sent must have "token", "latitude" and "longitude" keys
    latter 2 must be convertable to float

    Sends a data message with score and number of disasters
    to device with given token
    """
    json_data = request.get_json()
    try:
        lat = float(json_data["latitude"])
        lon = float(json_data["longitude"])
        token = json_data["token"]
        log(token,'received POST request at /score')
        add({"token": token, "latitude": lat, "longitude": lon})
    except:
        log('-999','incorrect POST request at /score')
        return {"score": -1}

    data = get_score_num(lat,lon)
    log(token,'sent data: score')
#    _send_fcm_message(_build_common_message(token, data=data))
    return data

if __name__ == "__main__":
    pass
    #app.run(host='0.0.0.0',port=5000)
    #data = {"token": "223456", "latitude": -41.5, "longitude": 100, "amt_donated": 0, "safe": 0, "num_donations": 0, "time": "2018-25-12-16-10-40"}
    #pprint(db.all())
    #add(data)
