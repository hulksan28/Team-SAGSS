from flask import Flask, jsonify, render_template, redirect, request, session,Response,send_file
import flask
import mysql.connector
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
			return render_template("food.html",food_menu = food_menu)
		
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