mysql = MySQL(app)

# create db engine and connection to it
from sqlalchemy import create_engine
engine = db.create_engine('mysql://root:emerge@localhost:3306/emerge')
connection = engine.connect()
metadata = db.MetaData()

Session = sessionmaker(bind=engine)
session = Session()

#create database Table objects for sqlalchemy to interact with
report = db.Table('Report', metadata, autoload=True, autoload_with=engine)
municipality = db.Table('Municipality', metadata, autoload=True, autoload_with=engine)
emerRespAgency = db.Table('EmergencyResponseAgency', metadata, autoload=True, autoload_with=engine)


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

#end add_muni

#get_muni_reports
#get all the reports of a municipality by the municipality_id
#returns a list of reports based on the inputted municipality_id
@app.route('/get_muni_reports', methods=['POST', 'OPTIONS'])
@cross_origin()
def get_muni_reports():

    #get municipality_id
    request_data = request.get_json()
    muni_id = request_data['municipality_id']

    #create query for all reports of a municipality
    query = db.select([report]).where(report.c.municipality_id == muni_id)
    queryResult = session.execute(query)
    session.commit()

    #get result
    resultSet = queryResult.fetchall()

    #convert result into a list
    resultDict = [dict((row, column) for row, column in row.items()) for row in resultSet]

    resultJSON = jsonify(resultDict)
    return(resultJSON)

#end get_muni_reports

#get_muni_services
#gets all the municipalities and their services
@app.route('/get_muni_services', methods=['GET', 'OPTIONS'])
@cross_origin()
def get_muni_services():
    
    #municipality.alias(municipality.c.municipality_id == muni_id)
    #municipality.alias(municipality.c.name == muni_name)
    joinClause = municipality.join(emerRespAgency, municipality.c.municipality_id == emerRespAgency.c.municipality_id)

    query = db.select([municipality.c.name.label("muni_name"), municipality.c.name, emerRespAgency.c.name]).select_from(joinClause).where(municipality.c.municipality_id == emerRespAgency.c.municipality_id)
    queryResult = session.execute(query)
    session.commit()

    resultSet = queryResult.fetchall()
    resultDict = [dict((key, value) for key, value in row.items()) for row in resultSet]

    resultJSON = jsonify(resultDict)

    return(resultJSON)

#end get_muni_services

#testValue 
#return int
@app.route('/test', methods=['GET'])
def test():
    #get test

    return jsonify({"test" : 'SHOW EM'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
