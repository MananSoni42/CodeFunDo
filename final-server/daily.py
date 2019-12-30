import os
from tinydb import TinyDB, Query

db = TinyDB('database.json')
user = Query()

def scrape():
    os.system('python3 scrape.py')

def check_safe_notif():
    notif_data = {"notification": 1}
    for row in db.search(user.safe == 0):
        _send_fcm_message(_build_common_message(token=row["token"],notif={"title": 'ARE YOU SAFE',"body": 'Please mark yourself as safe/unsafe'}, data=notif_data))

def send_tips():
    ## TODO:
    pass
