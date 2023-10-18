# Importing the frameworks

from flask import *
from datetime import datetime
import database

user_details = {}
session = {}
page = {}

# Initialise the application
app = Flask(__name__)
app.secret_key = 'aab12124d346928d14710610f'


#####################################################
##  INDEX
#####################################################

@app.route('/')
def index():
    # Check if the user is logged in
    if('logged_in' not in session or not session['logged_in']):
        return redirect(url_for('login'))
    page['title'] = 'Rent-A-Car Australia'
    
    return redirect(url_for('list_car'))

    #return render_template('index.html', session=session, page=page, user=user_details)

#####################################################
##  LOGIN
#####################################################

@app.route('/login', methods=['POST', 'GET'])
def login():
    # Check if they are submitting details, or they are just logging in
    if (request.method == 'POST'):
        # submitting details
        login_return_data = check_login(request.form['id'], request.form['password'])

        # If they have incorrect details
        if login_return_data is None:
            page['bar'] = False
            flash("Incorrect login info, please try again.")
            return redirect(url_for('login'))

        # Log them in
        page['bar'] = True
        welcomestr = 'Welcome back, ' + login_return_data['firstName'] + ' ' + login_return_data['lastName']
        flash(welcomestr)
        session['logged_in'] = True

        # Store the user details
        global user_details
        user_details = login_return_data
        return redirect(url_for('index'))

    elif (request.method == 'GET'):
        return(render_template('login.html', page=page))

#####################################################
##  LOGOUT
#####################################################

@app.route('/logout')
def logout():
    session['logged_in'] = False
    page['bar'] = True
    flash('You have been logged out. See you soon!')
    return redirect(url_for('index'))

#####################################################
##  List Car
#####################################################

@app.route('/list_car', methods=['POST', 'GET'])
def list_car():
    # Check if user is logged in
    if ('logged_in' not in session or not session['logged_in']):
        return redirect(url_for('login'))

    # User is just viewing the page
    if (request.method == 'GET'):
        # First check if specific car
        car_list = database.findCarsByEmployee(user_details['userName'])
        if (car_list is None):
            car_list = []
            flash("There are no cars in the system for " + user_details['firstName'] + " " + user_details['lastName'])
            page['bar'] = False
        return render_template('car_list.html', car=car_list, session=session, page=page)

    # Otherwise try to get from the database
    elif (request.method == 'POST'):
        search_term = request.form['search']
        if (search_term == ''):
            car_list_find = database.findCarsByEmployee(user_details['userName'])
        else:    
            car_list_find = database.findCarsByCriteria(search_term)
        if (car_list_find is None):
            car_list_find = []
            flash("Searching \'{}\' does not return any result".format(request.form['search']))
            page['bar'] = False
        return render_template('car_list.html', car=car_list_find, session=session, page=page)

#####################################################
##  Add Car
#####################################################

@app.route('/new_car' , methods=['GET', 'POST'])
def new_car():
    # Check if the user is logged in
    if ('logged_in' not in session or not session['logged_in']):
        return redirect(url_for('login'))

    # If we're just looking at the 'new car' page
    if(request.method == 'GET'):
        times = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        return render_template('new_car.html', user=user_details, times=times, session=session, page=page)

	# If we're adding a new car
    success = database.addCar(request.form['make'],
                              request.form['model'],
                              request.form['type'],
                              request.form['wheel'],
                              request.form['purchasedate'],
                              request.form['description'])
    if(success == True):
        page['bar'] = True
        flash("Car added!")
        return(redirect(url_for('index')))
    else:
        page['bar'] = False
        flash("There was an error adding a new car")
        return(redirect(url_for('new_car')))

#####################################################
## Update Car
#####################################################
@app.route('/update_car', methods=['GET', 'POST'])
def update_car():
    # Check if the user is logged in
    if ('logged_in' not in session or not session['logged_in']):
        return redirect(url_for('login'))

    # If we're just looking at the 'update car' page
    if (request.method == 'GET'):
        make = request.args.get('makemodel').split(" ")[0]
        model = request.args.get('makemodel')[len(make)+1:]
        type = request.args.get('typewheel').split(" ")[0]
        wheel = request.args.get('typewheel')[len(type)+3:]

        # Get the car
        car = {
            'car_id': request.args.get('car_id'),
            'make': make,
			'model': model,
            'status': request.args.get('status'),
            'type': type,
            'wheel': wheel,
            'purchasedate': datetime.strptime(request.args.get('purchasedate'), '%d/%m/%Y').date(),
            'employee': request.args.get('employee'),
            'description': request.args.get('description')
        }

        # If there is no car
        if car['car_id'] is None:
            car = []
		    # Do not allow viewing if there is no car to update
            page['bar'] = False
            flash("You do not have access to update that record!")
            return(redirect(url_for('index')))

	    # Otherwise, if car details can be retrieved
        times = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        return render_template('update_car.html', carInfo=car, user=user_details, times=times, session=session, page=page)

    # If we're updating car
    success = database.updateCar(request.form['car_id'],
                                request.form['make'],
                                request.form['model'],
                                request.form['status'],
                                request.form['type'],
                                request.form['wheel'],
                                request.form['purchasedate'],
                                request.form['employee'],
                                request.form['description'])

    if (success == True):
        page['bar'] = True
        flash("Car record updated!")
        return(redirect(url_for('index')))
    else:
        page['bar'] = False
        flash("There was an error updating the car")
        return(redirect(url_for('index')))

def get_car(car_id, username):
    for car in database.findCarsByEmployee(username):
        if car['car_id'] == car_id:
            return car
    return None

def check_login(username, password):
    userInfo = database.checkEmployeeCredentials(username, password)

    if userInfo is None:
        return None
    else:
        tuples = {
            'userName': userInfo[0],
            'password': userInfo[1],
            'firstName': userInfo[2],
            'lastName': userInfo[3],
            'phoneNo': userInfo[4],
            'email': userInfo[5],
            'postalAddress': userInfo[6]
        }
        return tuples
