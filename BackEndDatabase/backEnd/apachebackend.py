from flask import Flask, render_template, request
from flask_mysqldb import MySQL
from flask import jsonify
from sqlalchemy import *
import flask_cors
from flask_cors import CORS, cross_origin
import sqlalchemy as db
import json

app = Flask(__name__)
CORS(app)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'emerge'
app.config['MYSQL_DB'] = 'emerge'

mysql = MySQL(app)

# create db engine and connection to it
from sqlalchemy import create_engine
engine = create_engine('mysql://root:emerge@localhost:3306/emerge')
connection = engine.connect()
metadata = db.MetaData()
#create database Table objects for sqlalchemy to interact with
emerRespAgency = db.Table('EmergencyResponseAgency', metadata, autoload=True, autoload_with=engine)
report = db.Table('Report', metadata, autoload=True, autoload_with=engine)



#retrieves all emergency response agencies for all municipalities
#receives: empty GET request
#returns: JSON all responding agencies for all municipalities
@app.route('/get_all_agency', methods=['GET'])
def get_all_agency():

     print(emerRespAgency.columns.keys())

     #outString = " "
     #return outString.join(emerRespAgency.columns.keys())

     #return json.dumps(emerRespAgency.columns.keys())
     query = db.select([emerRespAgency])
     #return json.dumps(query)

     queryResult = connection.execute(query)
     
     resultSet = queryResult.fetchall()

     resultJSON = jsonify(dict(row) for row in resultSet)
     return json.dumps(str(resultJSON))
     

#end get_all_agency()


#updates GPS location for a given report
#receives: JSON { "report_id" : <int report_id>"GPS" : <String GPS> } via POST
#returns: JSON same as input
@app.route('/change_report_gps', methods = ['PUT'])
def change_report_gps():
     req_data = request.get_json()

     gpsCoord = req_data['GPS']
     reportNum = req_data['report_id']
     
     query = update(report).where(report.c.report_id==reportNum).\
          values(GPS=gpsCoord)

     #print (query)
     #print (str(gpsCoord))
     #print (str(reportNum))
     
     connection.execute(query)
     
     return jsonify({'GPS' : str(gpsCoord)})

#end change_report_gps()


#adds a new report ###########note: this query does not currently support blob for picture#############
#receives: JSON { "timestamp" : <String timestamp>, "required_responders" : <String requiredResponders>, "status" : <String reportStatus>,
#   "urgency" : <String reportUrgency>, "GPS" : <String reportGPS>, "name" : <String reportName>, "phone" : <String reportPhone>, "photo" : reportPhoto,
#   "message" : <String reportMessage>, "report_level" : <String reportLevel>, "type" : <String reportType> } via POST
#returns: JSON with report_id of inserted report
@app.route('/add_report', methods = ['PUT'])
def add_report():
     req_data = request.get_json()

     #reportNum = req_data['report_id'] ####this should be autofilled and gotten from mySQL
     reportTimeStamp = req_data['timestamp']
     reportRequiredResponders= req_data['required_responders']
     reportStatus = req_data['status']
     reportUrgency = req_data['urgency']
     reportGPS = req_data['GPS']
     reportName = req_data['name']
     reportPhone = req_data['phone']
     reportPhoto = req_data['photo']
     reportMessage = req_data['message']
     reportMunicipalityId = 1#this is a stub currently; place function to assign muni from gps coord here
     reportLevel = req_data['report_level']
     reportType = req_data['report_type']
    
     
     query = report.insert().values(timestamp=reportTimeStamp,
            required_responders = reportRequiredResponders,
            status = reportStatus,
            urgency = reportUrgency,
            GPS = reportGPS,
            name = reportName,
            phone = reportPhone,
            #photo = reportPhoto,
            message = reportMessage,
            municipality_id = reportMunicipalityId,
            report_level = reportLevel,
            report_type = reportType)

     
     queryResult = connection.execute(query)

     #result = dict((k, [k]) for k

     return jsonify({"report_id" : queryResult.inserted_primary_key[0]})

#end add_report()


#retrieves report
#receives: JSON { "report_id" : <int reportId> }
#returns: JSON all fields from report row
@app.route('/get_report', methods=['GET', 'OPTIONS'])
@cross_origin()
def get_report():

     #get input JSON
     req_data = request.get_json()
     reportId = req_data['report_id']

     #build query
     query = report.select().where(report.c.report_id == report_id)

     #execute query and store resolt proxy
     queryResult = connection.execute(query)

     #get result row set
     resultSet = queryResult.fetchall()

     #convert result row set to list
     resultList = [dict(row) for row in resultSet]
     print(resultList)

     #convert result list to dictionary
     resultDict = resultList[0]
     print(resultDict)

     #jsonifiy and return query results
     resultJSON = jsonify(resultDict)
     
     return(resultJSON)
     

#end get_report()


#add municipality
@app.route('/add_muni', methods=['PUT', 'OPTIONS'])
@cross_origin()
def add_muni():

    #get input JSON
    request_data = request.get_json()

    jurisdictionRadius = request_data['jur_radius']
    muniName = request_data['name']
    muniState = request_data['state']
    muniUID = request_data['UID']

    new_muni = municipality.insert().values(jurisdiction_radius = jurisdictionRadius,
            name = muniName,
            state = muniState,
            UID = muniUID)

    queryResult = connection.execute(new_muni)

    return jsonify({"municipality_id" : queryResult.inserted_primary_key[0]})

#end add_muni()


#retrieves report
#receives: JSON { "report_id" : <int reportId> }
#returns: JSON all fields from report row
@app.route('/update_status', methods=['GET', 'POST', 'PUT'])
@cross_origin()
def update_status():

    #get input JSON
    request_data = request.get_json()
    reportId = request_data['report_id']
    newStatus = request_data['status']

    query = update(report).where(report.c.report_id == reportId).\
            values(status = newStatus)
    connection.execute(query)

    #jsonify and return query results
    return jsonify({'status' : str(newStatus)})

#end add_muni()

#retrieves report status
#receives: JSON { "report_id" : <int reportId> }
#returns: JSON field of the status of the desired report
@app.route('/get_status', methods=['GET', 'OPTIONS'])
def get_status():

    #get input JSON
    request_data = request.get_json()
    reportId = request_data['report_id']

    query = select([report.c.status]).where(report.c.report_id == reportId)
    queryResult = connection.execute(query)
    resultSet = queryResult.fetchone()
    resultList = dict(resultSet)
    #resultDict = resultList[0]
    print(resultList)

    #jsonify and return query results
    resultJSON = jsonify(resultList)
    return(resultJSON)
    #return jsonify({"status" : resultSet})
#end of get_status



#testValue
#return int
@app.route('/test', methods=['GET'])
def test():
    #get test

    return jsonify({"test" : 'SHOW EM'})
#end test



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)

