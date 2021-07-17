import os
import MySQLdb
from datetime import datetime
from flask import Flask, render_template, request, url_for, session, jsonify
from flask_mysqldb import MySQL
import re
import json
#import server_doctor.py
app = Flask(__name__)

app.secret_key = 'your secret key'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
#app.config['MYSQL_HOST'] = 'aim.cvot3mbu0m9d.us-east-2.rds.amazonaws.com'
#app.config['MYSQL_USER'] = 'gismaster'
# app.config['MYSQL_PASSWORD'] = 'first#1234'

app.config['MYSQL_DB'] = 'lacto'
mysql = MySQL(app)


@app.route("/")
def index():
    return render_template("index.html", message="Hello Flask!")
    
# All ablut login and session. Takenfrom other site.
@app.route('/login')
@app.route('/login', methods=['GET', 'POST'])
def login():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor = mysql.connection.cursor()
        cursor.execute(
            'SELECT * FROM user WHERE username = % s AND password = % s and is_active=True', (username, password, ))
        account = cursor.fetchone()
        profile_set=1
        #print ("account=",account)
        if account:
            #print ("accountID=", account[0])
            session['loggedin'] = True
            #session['id'] = account['id']
            session['session_id'] = account[0]
            #session['username'] = account['username']
            session['username'] = account[2]
            session['role'] = account[3]
            session['name'] = account[4]
            msg = 'Logged in successfully ! Session on'
            doner_login_page='doner_login.html'     #default page when profile present. 
            cursor.execute( 'SELECT * FROM profile WHERE id = %s ', (account[0], ))    
            profile_present = cursor.fetchone()
            if not profile_present :
                #profile_create()
                print('IN Profile present:', account[0])
                doner_login_page='profile_create.html'
            if session['role'] in ('admin'):
                return render_template('index_admin.html', msg=msg, session_id=session['session_id'], session_username=session['username'], role=session['role'])
            elif session['role'] in ('doner'):
                return render_template(doner_login_page, msg=msg, session_id=session['session_id'], session_username=session['username'], role=session['role'], session_name=session['name'])
            elif session['role'] in ('doctor') :
                return render_template('doctor/doctor_login.html', msg=msg, session_id=session['session_id'], session_username=session['username'], role=session['role'], session_name=session['name'])

            else:
                return render_template('index_login.html', msg=msg, session_id=session['session_id'], session_username=session['username'], role=session['role'], name=session['name'])
        else:
            msg = 'Incorrect username / password !'
            
    return render_template('login.html', msg=msg)

def profile_create1():            #Unused
    return('Create Profile !')
@app.route('/profile_create')     #Unused
def profile_create():
    return('create and save Profile !')

@app.route('/logout')
def logout():
    session.pop('loggedin', None)
    session.pop('session_id', None)
    session.pop('username', None)
    # return redirect(url_for('/login'))
    return render_template('login.html')


@app.route('/register', methods=['GET', 'POST'])
def register():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form:
        username = request.form['username']
        password = request.form['password']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        email = request.form['email']
        date_joined = '2021-05-06 00-00-00'        
        role = request.form['role']
        role = role.lower()
        
        is_active = '1'
        #cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor = mysql.connection.cursor()
        cursor.execute(
            'SELECT * FROM user WHERE username = % s', (username, ))
        account = cursor.fetchone()
        if account:
            msg = 'Account already exists !'
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Invalid email address !'
        elif not re.match(r'[A-Za-z0-9]+', username):
            msg = 'Username must contain only characters and numbers !'
        elif not username or not password or not email:
            msg = 'Please fill out the form !'

        else:
            cursor.execute('INSERT INTO user (username, password, email, first_name, last_name, is_active, role )             VALUES (%s, %s, %s, %s, %s, %s, %s)', (username, password, email, first_name, last_name, is_active, role)) 
            
            mysql.connection.commit()
            msg = 'User successfully registered !'
    elif request.method == 'POST':
        msg = 'Please fill out the form !'
    return render_template('register.html', msg=msg)

 # display table columns and rows in html

@app.route('/profile', methods=['GET', 'POST'])
def profile():
    username = session.get("username")
    userid = session.get("session_id")
    role = session.get("role")
    username = str(username)
    #username =str('ram')
    print('USER ',username,userid)
    cursor = mysql.connection.cursor()
    cursor.execute('SELECT * FROM user where username = %s', (username,)) 
    data = cursor.fetchall()
    #userid=4
    userid=str(userid)
    cursor.execute('SELECT * FROM profile where id = %s', (userid,)) 
    #cursor.execute('select id, birthdate, json_extract(address,\'$.name\'), contact_no, emailid, aadhar_cd_no from profile where id = %s', (userid,))
    data_profile = cursor.fetchall()
    for row in data_profile:
            dob = row[2]
            contact_no = row[4]
            aadhar_no = row[6]
            address = row[3]
            
    #data_p1 = " ".join(payload)
    #data_p1 = data_p[1:-1] 
    #data_p1=data_p.replace('\[', '')
    user_details = {'name': 'John', 'email': 'john@doe.com' }   
    #print('user ', data_profile)
    #print ('DATA 2 ')
    #data_p = {'id': 1, 'address': '32 Anjanwadi, Sadashive Peth, Pune 411013', 'password': 2}
    return render_template('profile.html', data=data, user_d=user_details, dob=dob, contact_no=contact_no, address=address, aadhar_no=aadhar_no, role=role)

@app.route('/profile_edit', methods=['GET', 'POST'])
def profile_edit():
    cursor = mysql.connection.cursor()
    userid = session.get("session_id")
    username = session.get("username")
    role = session.get("role")
    cursor = mysql.connection.cursor()
    cursor.execute('SELECT * FROM user where username = %s', (username,)) 
    data = cursor.fetchall()    
    cursor.execute('SELECT * FROM profile where id = %s', (userid,)) 
    data_profile = cursor.fetchall()
    for row in data_profile:
            dob = row[2]
            contact_no = row[4]
            aadhar_no = row[6]
            address = row[3]
    profile_route = request.form['profile']
    print ('In profile up-',profile_route)
    if 'Edit' in profile_route :
        return render_template('profile_edit.html', data=data, dob=dob, contact_no=contact_no, address=address, aadhar_no=aadhar_no, username=username, role=role)
    if 'Save' in profile_route :
        #Insert all values in profile for username, id
        dob = request.form['dob']
        contact_no = request.form['contact_no']
        address = request.form['address']
        emailid = request.form['email']
        aadhar_no=request.form['aadhar_cd_no']
        cursor.execute('SELECT * FROM profile where id = %s', (userid,)) 
        data_profile = cursor.fetchone()
        if not data_profile :
            cursor.execute(
                'INSERT INTO profile (id, address, birthdate, contact_no,  emailid,  aadhar_cd_no) values  (%s, %s, %s, %s, %s, %s)',(userid, address, dob, contact_no, emailid, aadhar_no,)) 
        else :
            cursor.execute( 
                'UPDATE profile set address = %s, emailid=%s, contact_no = %s, aadhar_cd_no=%s where id = %s', ( address, emailid, contact_no, aadhar_no, userid,))
        mysql.connection.commit()
        return render_template('profile.html', data=data, dob=dob, contact_no=contact_no, address=address, aadhar_no=aadhar_no, username=username, role=role)
    if 'Cancell' in profile_route :
        return render_template('profile.html', data=data, dob=dob, contact_no=contact_no, address=address, aadhar_no=aadhar_no, username=username, role=role)
    else :                   #Coming to profile first time. To create profile
        #cursor.execute(
        #    'INSERT INTO profile (id, address, birthdate, contact_no,  emailid,  aadhar_cd_no) values  (%s, %s, %s, %s, %s, %s)',(userid, address, dob, contact_no, emailid, aadhar_no,)) 
        #mysql.connection.commit()
        return(profile_route+" Option selected is not in list!")        

@app.route('/schedule',methods=['GET', 'POST'])
def schedule():
    return render_template("schedule_create.html")

@app.route('/schedule1', methods=['GET', 'POST'])  #Not used
def schedule1():
    cursor = mysql.connection.cursor()
    name = request.form['name']
    alist = request.form['alist']
    cursor.execute( 'INSERT INTO schedule_col (name, alist, enquiry_no_id ) values (% s, %s, 2)', (name, alist))
    mysql.connection.commit()
    return ('Data in table- success')

@app.route('/doner_info',methods=['GET', 'POST'])
def doner_info():
    username = session.get("username")
    userid = session.get("session_id")
    role = session.get("role")

    #print ("Role ",role)
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor = mysql.connection.cursor()
    cursor.execute('SELECT * FROM profile where id = %s', (userid,)) 
    data_profile = cursor.fetchall()
    for row in data_profile:
            dob = row[2]
            contact_no = row[4]
            aadhar_no = row[6]
            address = row[3]
    cursor.execute(
            'SELECT * FROM doner_info WHERE id = %s ', (userid, ))
    accounts = cursor.fetchone()              #If accounts exists then show database record. If not show blank form to doner.
    if accounts:
        print ("Account  ", accounts[16])     #This field has json data of all page (page_info) elements
        account = json.loads(accounts[16])
        #print ("account=",account)
        return render_template("doner_info_post.html", accounts = account, username=username, role=role)
    else:                       #New doner. Take doner_info and save
        return render_template("doner_info.html", role=role, username=username, userid=userid, address=address, contact_no=contact_no, dob=dob)

@app.route('/doner_reg',methods=['GET', 'POST'])
def doner_reg():
    cursor = mysql.connection.cursor()
    username = session.get("username")
    userid = session.get("session_id")
    #role = request.form['role']
    role = session.get("role")
    parameter = request.form['donereg']
    print ('ParaMeter', parameter,username,userid)

    cursor.execute( 'SELECT * FROM doner_info WHERE id = %s ', (userid, ))
    accounts = cursor.fetchone()
    if accounts:                               #If accounts exists then update record. If no then create one and save.
        #print ("Account  ", accounts[16])     #This field has json data of complete page (page_info) elements
        account = json.loads(accounts[16])
        cursor.execute( 'UPDATE doner_info set parameters = %s where id = %s', ( parameter, userid,))
        mysql.connection.commit()
        return render_template("doner_info_post.html", accounts = account, username=username, role=role)
    else :
        cursor.execute( 'INSERT INTO doner_info (id, parameters ) values (%s, %s)', (userid, parameter,))
        mysql.connection.commit()
    return render_template("doner_info1.html", role=role)

@app.route('/track_doner1', methods=['GET', 'POST'])
def track_doner():
    cursor = mysql.connection.cursor()
    role = session.get("role")
    cursor.execute("SELECT * FROM user where role='doner'")
    data = cursor.fetchall()
    adata='1'
    return render_template('doctor/track_doner.html', data=data, adata=adata, role=role)

@app.route('/disp_table', methods=['GET', 'POST'])
def disp_table():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM enquiry")
    data = cursor.fetchall()
    return render_template('disp_table.html', data=data)


@app.route('/page1/<my_var>')
def page1(my_var):
    # but_id = str(request.form['myBut'])
    # my_var = request.args.get('my_var', None)
    print(request.form.get('my_var'))
    print(my_var)
    return render_template("page1.html", my_var=my_var)
    print("but_id=", but_id)
    #but_id = str(request.args.get('myBut'))
    return but_id


@app.route('/disp_table1')
def disp_table1():
    # but_id = str(request.form['myBut'])
    recid = request.args.get('recid')
    recid = str(recid)
    print(request.form.get('recid'))
    # print(my_var)
    # return render_template("page1.html", my_var=my_var)
    print("but_id=", recid)
    #but_id = str(request.args.get('myBut'))
    return ('recid=' + recid)


@app.route('/page2', methods=['GET', 'POST'])
def page2():
    name = request.form['name']
    age = request.form['age']
    radio = request.form['nameradio']
    but_pressed = request.form['open']
    # Use following (topen) when using submit direclty from  table rows. Refer pagetable.html
    #edit_pressed = request.form['topen']
    print(name, ' ', age, ' ', radio)
    return render_template("page2.html", name=name, age=age, radiovalue=radio, but_pressed=but_pressed)


@app.route('/page')
def page():
    return render_template("postpage.html")


@app.route('/pagetable')
def pagetable():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM enquiry")
    data = cursor.fetchall()
    return render_template('pagetable.html', data=data)
    # return render_template("pagetable.html")


@app.route('/insert')
def insert():
    return render_template('insert_table.html')


@app.route('/insert_table', methods=['GET', 'POST'])
def insert_table():
    cursor = mysql.connection.cursor()
    name = request.form['name']
    alist = request.form['alist']
    cursor.execute( 'INSERT INTO visit (name, alist, enquiry_no_id ) values (% s, %s, 2)', (name, alist))
    mysql.connection.commit()
    return ('Data in table- success')

# manage user profile: user psw, contant no, email, address, User_id(not editable), is_active, role


@app.route('/changepsw', methods=['GET', 'POST'])
def changepsw():
    msg = ''
    errflg = ''
    if request.method == 'POST' and 'username' in request.form:
        username = request.form['username']
        new_psw = request.form['new_psw']
        rep_new_psw = request.form['rep_new_psw']
        old_psw = request.form['old_psw']
        #cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor = mysql.connection.cursor()
        cursor.execute(
            'SELECT * FROM accounts WHERE username = % s', (username, ))
        account = cursor.fetchone()
        #print("Form contains :",username,old_psw, new_psw, rep_new_psw, account, account[2])
        #print('compare old-psw=',old_psw,' and ',account[2])
        if account:
            msg = 'Account exists !'
            if not re.match(r'[A-Za-z0-9]+', new_psw):
                msg = 'New Password must contain only characters and numbers !'
                errflg = 'error'
            if new_psw != rep_new_psw:
                msg = 'psw and repeat psw should be same !'
                errflg = 'error'
            if old_psw != account[2]:
                print('MSG=', old_psw, account[2])
                msg = 'Incorrect current password'
                errflg = 'error'
            if errflg:
                print("error in form.")
            else:
                print("can insert values of new psw")
                msg = 'Success Change password !'
                # INSERT INTO accounts VALUES (NULL, % s, % s, % s)', (username, password, email, ))
                cursor = mysql.connection.cursor()
                cursor.execute(
                    ('UPDATE accounts set password=%s where id = %s'), (new_psw, account[0]))
                mysql.connection.commit()

        else:
            msg = 'You should have account registered !'
    elif request.method == 'POST':
        msg = 'Please fill out the form !'
    return render_template('changepsw.html', msg=msg)


# Display all vender list in table
@app.route('/select_vender')
def select_vender():
    if 'session_id' in session:
        sessionid = session['session_id']
        session_role = session['role']

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT name, vender_id, address FROM vender")
        data = cursor.fetchall()
        venderid = request.args.get('venderid')
        print("in vender id= ", venderid)
        if session_role == 'admin':
            return render_template('select_vender.html', data=data, venderid=venderid, role=session_role)
        else:
            return render_template('select_vender.html', data=data, venderid=venderid, role=session_role)
    else:
        return '<p>Please login first</p>'


@app.route('/select_dept')
def select_dept():
    if 'session_id' in session:
        sessionid = session['session_id']
        print("in dept sessionid= ", sessionid)
        sel = request.args.get('dept')
        venderid = request.args.get('venderid')
        print("vender =", venderid)
        cursor = mysql.connection.cursor()
        #cursor.execute("SELECT equ_name, equ_parameter_id  FROM equipment")
        cursor.execute("SELECT department_name, department_id FROM department")
        data = cursor.fetchall()
        return render_template('select_dept.html', data=data, deptid=sel, venderid=venderid)
    else:
        return '<p>Please login first</p>'
    #sel = request.args.get('vender')
    #cursor = mysql.connection.cursor()
    #cursor.execute("SELECT department_name, department_id FROM department")
    #data = cursor.fetchall()
    # return render_template('select_dept.html', data=data, venderid=sel)


@app.route('/select_equip')
def select_equip():
    if 'session_id' in session:
        sessionid = session['session_id']
        sel = request.args.get('deptid')
        venderid = request.args.get('venderid')
        print("venderid in eq=", venderid)
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT equ_name, equ_parameter_id  FROM equipment")
        data = cursor.fetchall()
        return render_template('select_equip.html', data=data, deptid=sel, venderid=venderid)
    else:
        return '<p>Please login first</p>'

# get comma seperated record and show in table


@app.route('/hosplist')
def hosplist():
    equipid = request.args.get('equipment')
    print("EQP=", equipid)
    cursor = mysql.connection.cursor()
    cursor.execute(
        "SELECT parameter_name FROM equ_parameter_reg where equ_parameter_id=%s", (equipid,))
    data = cursor.fetchall()
    s = "-"
    for row in data:
        print(row)
        s = s.join(row)
        rowx = s.split(',')

    return render_template('hosplist.html', data=rowx)


@app.route('/parameter_input')
def parameter_input():
    if 'session_id' in session:
        deptid = request.args.get('deptid')
        venderid = request.args.get('venderid')
        equipmentid = request.args.get('equipmentid')
        cursor = mysql.connection.cursor()
        cursor.execute(
            'SELECT equ_name, equ_parameter_id FROM equipment where equ_id =%s', (equipmentid,))
        #equ_name = cursor.fetchone()
        data = cursor.fetchall()
        for row in data:
            equ_name = row[0]
            equ_parameter_id = row[1]

        print('EQUIP=', equ_name, equ_parameter_id)
        cursor.execute(
            "SELECT parameter_name FROM equ_parameter_reg where equ_parameter_id=%s", (equ_parameter_id,))
        data = cursor.fetchall()
        s = "-"
        for row in data:
            print(row)
            s = s.join(row)
            rowx = s.split(',')
            return render_template('parameter_input.html', data=rowx, venderid=venderid, deptid=deptid, equipmentid=equipmentid, equ_name=equ_name)
    else:
        return '<p>Please login first.</p>'


@app.route('/save_reading', methods=['GET', 'POST'])
def save_reading():
    if 'session_id' in session:
        sessionid = session['session_id']
        if request.method == 'POST':
            #equipmentid = request.args.get('equipmentid')
            print(request.form)
            print(request.form.to_dict())
            form_obj = request.form.to_dict()
            equipmentid = request.form['equipmentid']
            form_values = request.form['textall']
            remark = request.form['Remarks']
            approvar_name = request.form['approvar_name']
            approvar_email = request.form['approvar_email']
            try:
                verified1 = request.form['verified']
                varified1 = 0
            except:
                varified1 = 1

            #print ("varified=",verified)
            # if verified != 'on':
            #    verified =0
            #followed = request.form['followed']
            # approvar_email='rajan22@mail.com'

            # Get equ_parameter_id from equipmentid
            cursor = mysql.connection.cursor()
            cursor.execute(
                'SELECT equ_name, equ_parameter_id FROM equipment where equ_id =%s', (equipmentid,))
            data = cursor.fetchall()
            for row in data:
                equ_name = row[0]
                equ_parameter_id = row[1]

            # get parameter_names (list) in array defined from equ_parameter_id
            cursor.execute(
                'SELECT parameter_name FROM equ_parameter_reg where equ_parameter_id =%s', (equ_parameter_id,))
            data = cursor.fetchall()
            for row in data:
                parameter_name = row[0]

            para_name = str(parameter_name)

            # split on | and get a parameter list
            #para_list = form_values.split("|")

            # remove unwanted elements from list
            #del para_list[-8]
            #del para_list[-1]
            #del para_list[-1]
            #del para_list[-1]
            #del para_list[-1]
            #del para_list[-1]
            #del para_list[-1]
            #del para_list[-1]
            #del para_list[-1]
            #del para_list[2]

            # Again join and get string with | seperated values in string.
            #from_values_m = '|'.join(map(str, para_list))
            timestamp = datetime.now()
            cur_date = timestamp.strftime("%Y-%m-%d")

            # insert all the values along with (coma seperated) data string (parameter_readings in calibrate).
            #cursor.execute('insert  into calibrate (id, equ_id, parameter_readings, perform_date, approvar_name, remark,approvar_email,digitally_signed ) values (%s,%s,%s, %s, %s, %s,%s,%s)', (sessionid,equipmentid,from_values_m,cur_date, approvar_name, remark,approvar_email,verified1,))
            # mysql.connection.commit()
            cursor.execute('insert  into calibrate (id, equ_id, parameter_readings, perform_date ) values (%s,%s,%s, %s)',
                           (sessionid, equipmentid, form_obj, cur_date,))
            mysql.connection.commit()
            #print ('Parameter=', from_values_m,' Name=',para_list,'Inserted OKLEN=',len(para_list))
            # return "para_name ", parameter_name," Name=",parameter_name
            return str(form_values)

    else:
        return '<p>Please login first</p>'


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
