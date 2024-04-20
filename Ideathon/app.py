from flask import Flask, jsonify, render_template, redirect, request, session,Response,send_file,url_for
import flask
import mysql.connector
import json

# from werkzeug.utils import secure_filename



app = Flask(__name__)
app.secret_key = "sasank"


UPLOAD_FOLDER = 'static/uploads/'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


mydb = mysql.connector.connect(
	host = "localhost",
	user = "root",
	password = "",
	database = "sagss"
)
v_msg = ''


# =============================login============================================================================================
@app.route("/login", methods = ['POST', 'GET'])
def login():
	global v_msg
	if request.method == 'GET':
		if "user" in session:
			return redirect("/home")
		else:
			return render_template("login.html",err_msg = v_msg)
	if request.method == 'POST':
		values = request.form.to_dict()
		if values["adid"] == 'FOOD_VENDOR' or values["password"] == 'FOOD_VENDOR':
			session['user'] = 'FOOD_VENDOR'
			session['name'] = 'FOOD_VENDOR'
			return redirect("/food")
		mycursor = mydb.cursor()
		sql = "SELECT user_id,name FROM users WHERE adid = %s AND password = %s"
		val = (values["adid"], values["password"])
		mycursor.execute(sql, val)
		result = mycursor.fetchone()
		if result:
			session['user'] = result[0]
			session['name'] = result[1]
			return redirect("/home")
		else:
			v_msg = "invalid credentials"
			return redirect("/login")
# =============================home============================================================================================
@app.route("/")
@app.route("/home", methods = ['POST', 'GET'])
def home():
	if request.method == 'GET':
		if "user" in session:
			if session.get('user') == 'FOOD_VENDOR':
				return redirect("/food")
			mycursor = mydb.cursor()
			sql = "SELECT * FROM `users`"
			mycursor.execute(sql)
			myresult = mycursor.fetchall()
			return render_template("home.html",myresult = myresult)
		else:
			return redirect("/login")

# =============================locker============================================================================================
@app.route("/locker", methods = ['POST', 'GET'])
def locker():
	if request.method == 'GET':
		mycursor = mydb.cursor()
		sql = "SELECT distinct floor FROM `lockers` where user_id is null"
		mycursor.execute(sql)
		myresult = mycursor.fetchall()
		return render_template("locker.html",floor = myresult)
	if request.method == 'POST':
		values = request.form.to_dict()
		mycursor = mydb.cursor()
		sql = "select locker_no from `lockers` where user_id is null and floor = %s limit 1"
		val = (values["lockerfloor"],)
		mycursor.execute(sql,val)
		myresult = mycursor.fetchall()
		i = str(myresult[0][0])
		user_id = session.get('user')
		start_date = values["start_date"]
		end_date = values["end_date"]
		sql = "UPDATE lockers SET user_id = %s, from_date = %s, to_date = %s WHERE locker_no = %s and floor = %s"
		val = (user_id, start_date, end_date, i,values["lockerfloor"])
		mycursor.execute(sql, val)
		mydb.commit()
		return 'success'


# =============================locker============================================================================================
@app.route("/food", methods = ['POST', 'GET'])
def food():
	if request.method == 'GET':
		if "user" not in session:
			return redirect("/login")
		if session.get('user') == 'FOOD_VENDOR':
			mycursor = mydb.cursor()
			sql = "SELECT U.name,FM.foodlist FROM `food_mapping` FM inner join `users` U on FM.user_id = U.user_id"
			mycursor.execute(sql)
			food_menu = mycursor.fetchall()
			print("====================================")
			arr = []
			arr2 = []
			arr4 = []
			arr5 = []
			for i in food_menu:
				name = i[0]
				name2 = json.loads(i[1].replace("'", '"'))
				for key, valu in name2.items():
					if key != 'total':
						if int(valu) == 0:
							continue
						mycursor2 = mydb.cursor()
						sql = "SELECT food FROM `foodmenu` where id = %s"
						val = (int(key),)
						mycursor2.execute(sql,val)
						key = mycursor2.fetchone()[0]
						arr.append((name,key,int(valu),))
						# distinct keys and count of each key
						arr2.append(key)
						arr4.append(name)
			arr2 = list(set(arr2))
			arr3 = []
			for i in arr2:
				count = 0
				for j in arr:
					if j[1] == i:count += j[2]
				arr3.append((i,count,))
			arr4 = list(set(arr4))
			for i in arr4:
				for j in arr:
					count = 0
					if j[0] == i:
						f = j[1]
						for k in arr:
							if k[0] == i and k[1] == f:
								count += k[2]
						arr5.append((i,f,count,))
			arr5 = list(set(arr5))
			return render_template("food_vendor.html",food_menu = arr5,food_menu2 = arr3)
		
		mycursor = mydb.cursor()
		sql = "delete from `food_mapping` where date < curdate() - interval 1 day"
		mycursor.execute(sql)
		mydb.commit()

		mycursor = mydb.cursor()
		sql = "SELECT * FROM `foodmenu` where day = dayofweek(curdate()) and isactive = 1"
		mycursor.execute(sql)
		food_menu = mycursor.fetchall()
		return render_template("food.html",food_menu = food_menu)
	if request.method == 'POST':
		values = request.form.to_dict()
		# {'2': '2', '3': '1', 'total': '280.00'}
		
		mycursor = mydb.cursor()
		sql = "Insert into `food_mapping` (user_id,foodlist,price,date) values (%s,%s,%s,curdate())"
		val = (session.get('user'),str(values),values['total'],)
		mycursor.execute(sql,val)
		mydb.commit()
		return 'success'

# =============================meeting============================================================================================
from datetime import datetime, timedelta

# Dummy data for available rooms on each floor
floors = {
    "Floor 1": ["Room 101", "Room 102", "Room 103"],
    "Floor 2": ["Room 201", "Room 202", "Room 203"]
}

# Dummy data for booked rooms on each floor
booked_rooms = {
    "Floor 1": {
        "Room 101": [],
        "Room 102": [],
        "Room 103": []
    },
    "Floor 2": {
        "Room 201": [],
        "Room 202": [],
        "Room 203": []
    }
}


# Maximum duration for a booking (in hours)
MAX_DURATION_HOURS = 4

# Maximum booking window (in days) for future bookings
MAX_BOOKING_WINDOW_DAYS = 30

# Minimum duration for a practical booking (in minutes)
MIN_BOOKING_DURATION_MINUTES = 30

@app.route('/meeting_room', methods=['POST','GET'])
def meeting_room():
	if request.method == 'GET':
		mycursor = mydb.cursor()
		sql = "SELECT * FROM `meeting_room`"
		mycursor.execute(sql)
		myresult = mycursor.fetchall()
		print(myresult)
		return render_template("meeting_rooms.html", meetings = myresult)
	if request.method == 'POST':
		floor = request.form['floor']
		room = request.form['room']
		start_time_str = request.form['start_time']
		end_time_str = request.form['end_time']

		# Convert string inputs to datetime objects
		start_time = datetime.strptime(start_time_str, '%Y-%m-%dT%H:%M')
		end_time = datetime.strptime(end_time_str, '%Y-%m-%dT%H:%M')

		# Check if booking is for a past date or too far in the future
		if start_time < datetime.now():
			return "Cannot book for past dates.", 400
		if start_time > (datetime.now() + timedelta(days=MAX_BOOKING_WINDOW_DAYS)):
			return f"Cannot book for dates more than {MAX_BOOKING_WINDOW_DAYS} days in the future.", 400

		# Check if room is available for the requested time slot
		if floor in floors and room in floors[floor]:
			if not is_time_slot_available(floor, room, start_time, end_time):
				return "This room is already booked for the requested time slot. Please choose another time.", 400
			if not is_valid_time_range(start_time, end_time):
				return "Invalid time range. Please select a valid time range.", 400
			if not is_within_max_duration(start_time, end_time):
				return f"Maximum booking duration is {MAX_DURATION_HOURS} hours. Please select a shorter duration.", 400
			if not is_practical_duration(start_time, end_time):
				return f"Minimum practical booking duration is {MIN_BOOKING_DURATION_MINUTES} minutes. Please select a longer duration.", 400
			
			# If room is available, book the time slot
			booked_rooms[floor][room].append((start_time, end_time))
			return redirect(url_for('confirm_booking', floor=floor, room=room, start_time=start_time_str, end_time=end_time_str))

# Function to check if the requested time slot is available for the given room
def is_time_slot_available(floor, room, start_time, end_time):
    for booked_start, booked_end in booked_rooms[floor][room]:
        if (start_time <= booked_end and end_time >= booked_start) or (start_time == booked_end or end_time == booked_start) or (start_time == booked_end and end_time == booked_start):
            return False
    return True

# Function to check if the selected time range is valid (start time before end time)
def is_valid_time_range(start_time, end_time):
    return start_time < end_time

# Function to check if the duration of the booking is within the maximum allowed duration
def is_within_max_duration(start_time, end_time):
    duration = end_time - start_time
    return duration <= timedelta(hours=MAX_DURATION_HOURS)

# Function to check if the duration of the booking is practical (not too short)
def is_practical_duration(start_time, end_time):
    duration = end_time - start_time
    return duration >= timedelta(minutes=MIN_BOOKING_DURATION_MINUTES)

# @app.route("/meeting", methods = ['POST', 'GET'])
# def locker():
# 	if request.method == 'GET':
# 		mycursor = mydb.cursor()
# 		sql = "SELECT distinct floor FROM `meetings` where user_id is null"
# 		mycursor.execute(sql)
# 		myresult = mycursor.fetchall()
# 		return render_template("locker.html",floor = myresult)
# 	if request.method == 'POST':
# 		values = request.form.to_dict()
# 		mycursor = mydb.cursor()
# 		sql = "select locker_no from `meetings` where user_id is null and floor = %s limit 1"
# 		val = (values["lockerfloor"],)
# 		mycursor.execute(sql,val)
# 		myresult = mycursor.fetchall()
# 		i = str(myresult[0][0])
# 		user_id = session.get('user')
# 		start_date = values["start_date"]
# 		end_date = values["end_date"]
# 		sql = "UPDATE lockers SET user_id = %s, from_date = %s, to_date = %s WHERE locker_no = %s and floor = %s"
# 		val = (user_id, start_date, end_date, i,values["lockerfloor"])
# 		mycursor.execute(sql, val)
# 		mydb.commit()
# 		return 'success'

# =============================logout============================================================================================
@app.route("/logout")
def logout():
	session.clear()
	return redirect("/")

# @app.route('/data')
# def get_data():
#     data = [
#         {"id": 1, "name": "John", "age": 30},
#         {"id": 2, "name": "Alice", "age": 25},
#         {"id": 3, "name": "Bob", "age": 35}
#     ]
#     return jsonify(data)


if __name__ == '__main__':
	app.run(debug=True,port=7890)