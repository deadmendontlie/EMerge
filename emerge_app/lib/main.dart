import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'FirePage.dart';
import 'MedicalPage.dart';
import 'NonEmergenciesPage.dart';
import 'PolicePage.dart';
import 'TipsPage.dart';

void main() {
  _resetFile();
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter', initialRoute: '/', routes: {
      //starting page
      '/': (context) => StartScreen(),
      //other pages
      '/MedicalPage': (context) => MedicalPage(),
      '/PolicePage': (context) => PolicePage(),
      '/FirePage': (context) => FirePage(),
      '/TipsPage': (context) => TipsPage(),
      '/NonEmergenciesPage': (context) => NonEmergenciesPage(),
    });
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _localFile;
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      appBar: AppBar(
        title: Text('Start Screen'),
        backgroundColor: Color(0xFF2D3439),
      ),
      body: Container(
        child: Row(children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(width: 55),
                      Center(
                        child: RaisedButton(
                          padding: new EdgeInsets.all(20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.red)),
                          child: new Text('Medical',
                              style: new TextStyle(fontSize: 20.0)),
                          onPressed: () {
                            //Returns the reportID if it submitted currently when the function ends
                            _getReportID().then((reportID) {
                              if (reportID == -1) {
                                _navigateToMedicalPage(context)
                                    .then((newReportID) {
                                  int reportID = newReportID;
                                  if (reportID != -1 && reportID != null) {
                                    _writeDataToFile(
                                        'reportID:' + reportID.toString());
                                    _timer(0);
                                  }
                                });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'You cannot have more then one active report.'),
                                    );
                                  },
                                );
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 80),
                      Center(
                        child: RaisedButton(
                          padding: new EdgeInsets.all(20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.blue)),
                          child: new Text('Police',
                              style: new TextStyle(fontSize: 20.0)),
                          onPressed: () {
                            //Returns the reportID if it submitted currently when the function ends
                            _getReportID().then((reportID) {
                              if (reportID == -1) {
                                _navigateToPolicePage(context)
                                    .then((newReportID) {
                                  int reportID = newReportID;
                                  if (reportID != -1 && reportID != null) {
                                    _writeDataToFile(
                                        'reportID:' + reportID.toString());
                                    _timer(0);
                                  }
                                });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'You cannot have more then one active report.'),
                                    );
                                  },
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 70),
                      Center(
                        child: RaisedButton(
                          padding: new EdgeInsets.all(20.0),
                          child: new Text('Fire',
                              style: new TextStyle(fontSize: 20.0)),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.red)),
                          onPressed: () {
                            //Returns the reportID if it submitted currently when the function ends
                            _getReportID().then((reportID) {
                              if (reportID == -1) {
                                _navigateToFirePage(context)
                                    .then((newReportID) {
                                  int reportID = newReportID;
                                  if (reportID != -1 && reportID != null) {
                                    _writeDataToFile(
                                        'reportID:' + reportID.toString());
                                    _timer(0);
                                  }
                                });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'You cannot have more then one active report.'),
                                    );
                                  },
                                );
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 100, height: 100),
                      Center(
                        child: RaisedButton(
                          padding: new EdgeInsets.all(20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.green)),
                          child: new Text('Tips',
                              style: new TextStyle(fontSize: 20.0)),
                          onPressed: () {
                            //Returns the reportID if it submitted currently when the function ends
                            _getReportID().then((reportID) {
                              if (reportID == -1) {
                                _navigateToTipsPage(context)
                                    .then((newReportID) {
                                  int reportID = newReportID;
                                  if (reportID != -1 && reportID != null) {
                                    _writeDataToFile(
                                        'reportID:' + reportID.toString());
                                    _timer(0);
                                  }
                                });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'You cannot have more then one active report.'),
                                    );
                                  },
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 30),
                      Center(
                        child: RaisedButton(
                          padding: new EdgeInsets.all(20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.red)),
                          child: new Text(' \t \t \t \t Non \n Emergencies',
                              style: new TextStyle(fontSize: 20.0)),
                          onPressed: () {
                            //Returns the reportID if it submitted currently when the function ends
                            _getReportID().then((reportID) {
                              if (reportID == -1) {
                                _navigateToNonEmergenciesPage(context)
                                    .then((newReportID) {
                                  int reportID = newReportID;
                                  if (reportID != -1 && reportID != null) {
                                    _writeDataToFile(
                                        'reportID:' + reportID.toString());
                                    _timer(0);
                                  }
                                });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'You cannot have more then one active report.'),
                                    );
                                  },
                                );
                              }
                            });
                          },
                        ),
                      ),
                      //Posts an emergency report
                      SizedBox(width: 20),
                      Center(
                        child: RaisedButton(
                          padding: new EdgeInsets.all(20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.red)),
                          child: new Text('Emergencies',
                              style: new TextStyle(fontSize: 20.0)),
                          onPressed: () {
                            _getReportID().then((reportID) {
                              if (reportID == -1) {
                                _postEmergency().then((newReportID) {
                                  int finalReportID = newReportID;
                                  if (finalReportID != -1 && reportID != null) {
                                    _writeDataToFile(
                                        'reportID:' + finalReportID.toString());
                                    _timer(1);
                                  }
                                });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'You cannot have more then one active report.'),
                                    );
                                  },
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 30, height: 100),
                      Center(
                        child: RaisedButton(
                          padding: new EdgeInsets.all(20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.red)),
                          child: new Text('Get Report Status',
                              style: new TextStyle(fontSize: 20.0)),
                          onPressed: () {
                            _getReportID().then((reportID) {
                              int tempID = reportID;
                              if (tempID != -1) {
                                _fetchStatus(tempID).then((reportStatus) {
                                  String currentReportStatus = reportStatus;
                                  if (currentReportStatus != 'Closed') {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text('Report Status is ' +
                                              currentReportStatus),
                                        );
                                      },
                                    );
                                  } else {
                                    if (tempID != -1) {
                                      _resetFile();
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                                'Your report was closed and or solved'),
                                          );
                                        },
                                      );
                                    }
                                  }
                                });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content:
                                          Text('You have no active reports'),
                                    );
                                  },
                                );
                              }
                            });
                          }, //On pressed
                        ),
                      ),
                      //TODO remove this later
                      SizedBox(width: 20),
                      Center(
                        child: RaisedButton(
                          padding: new EdgeInsets.all(20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.red)),
                          child: new Text('Reset button',
                              style: new TextStyle(fontSize: 20.0)),
                          onPressed: () {
                            _resetFile();
                          }, //On pressed
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  //Transitions to the medical page
  Future<int> _navigateToMedicalPage(BuildContext context) async {
    return await Navigator.pushNamed(context, '/MedicalPage') as int;
  }

  //Transitions to the fire page
  Future<int> _navigateToFirePage(BuildContext context) async {
    return await Navigator.pushNamed(context, '/FirePage') as int;
  }

  //Transitions to the non-emergencies page page
  Future<int> _navigateToNonEmergenciesPage(BuildContext context) async {
    return await Navigator.pushNamed(context, '/NonEmergenciesPage') as int;
  }

  //Transitions to the medical page
  Future<int> _navigateToPolicePage(BuildContext context) async {
    return await Navigator.pushNamed(context, '/PolicePage') as int;
  }

  //Transitions to the medical page
  Future<int> _navigateToTipsPage(BuildContext context) async {
    return await Navigator.pushNamed(context, '/TipsPage') as int;
  }
}

//This will create objects to allow for easy parsing of a json file containing status
class Status {
  final String status;
  Status({this.status});
  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      status: json['status'],
    );
  }
  String get getStatus {
    return status;
  }
}

//This gets the current status of a report
Future<String> _fetchStatus(int id) async {
  var value = {"report_id": id};
  final Json = json.encode(value);
  final response = await http.post('http://18.212.156.43:80/get_status',
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: Json);
  if (response.statusCode == 200) {
    return Status.fromJson(json.decode(response.body)).getStatus;
  } else {
    throw Exception('Currently no active reports');
  }
}

//This gets a the users current location and then sends a request to update their report with new gps coordinates
Future<void> _updategps(int id) async {
  final location = await _getLocation();
  var value = {"report_id": id, "GPS": location.toString()};
  final Json = json.encode(value);
  final response = await http.put('http://18.212.156.43:80/change_report_gps',
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: Json);
  if (response.statusCode != 200) {
    throw Exception('Failed to update gps');
  }
}

//This gets the users current location
Future<Position> _getLocation() async {
  var currentLocation;
  try {
    currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  } catch (e) {
    currentLocation = null;
  }
  return currentLocation;
}

//This will create objects to allow for easy parsing of a json file containing report id
class ReportID {
  final int reportID;
  ReportID({this.reportID});
  factory ReportID.fromJson(Map<String, dynamic> json) {
    return ReportID(
      reportID: json['report_id'],
    );
  }
  int get getReportID {
    return reportID;
  }
}

//This will actually post the json file to the server
Future<int> _postReport(Object jsonData) async {
  final response = await http.put('http://18.212.156.43:80/add_report',
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: jsonData);
  if (response.statusCode == 200) {
    return ReportID.fromJson(json.decode(response.body)).getReportID;
  } else {
    throw Exception('Report was not submitted the status code was ' +
        response.statusCode.toString());
  }
}

//This creates a json file that will be sent to post report
Future<int> _postEmergency() async {
  Position userLocation = await _getLocation();
  String encodedLocation;
  String encodedDateTime;
  DateTime now = DateTime.now();
  encodedDateTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
  encodedLocation = userLocation.toString();
  var values = {
    "timestamp": encodedDateTime,
    "required_responders": 'FPH',
    "status": "New",
    "urgency": "High",
    "GPS": encodedLocation,
    "name": 'Anonymous',
    "phone": 'N/A',
    "photo": null,
    "message":
        'This is a emergency report we do not have anymore information at this time',
    "report_level": "Emergency",
    "report_type": 'Emergency'
  };
  final Json = json.encode(values);
  return await _postReport(Json);
}

//This get the local file path of the device and app
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

//This creates a info.txt file on the local system and writes the default value to it
Future<File> get _localFile async {
  final path = await _localPath;
  if (!File('$path/info.txt').existsSync()) {
    File temp = File('$path/info.txt');
    temp.writeAsStringSync('reportID:-1');
  } else {
    return File('$path/info.txt');
  }
}

//This writes to a file
Future<void> _writeDataToFile(String info) async {
  File file = await _localFile;
  file.writeAsStringSync(info);
}

//This gets the report ID from a file if it is in the specified format
Future<int> _getReportID() async {
  File file = await _localFile;
  String infoPreParsed = file.readAsStringSync();
  return int.parse(infoPreParsed.split(':').last);
}

//Resets the file to the default format and report id
void _resetFile() async {
  File temp = await _localFile;
  temp.writeAsStringSync('reportID:-1');
}

//This is a timer that runs every minute to get the status changes and will update gps
void _timer(int value) async {
  int reportID = await _getReportID();
  String status;
  Timer timerMin = new Timer.periodic(new Duration(minutes: 1), (time) async {
    status = await _fetchStatus(reportID);
    if (status == 'Closed') {
      time.cancel();
      _writeDataToFile('reportID:-1');
    } else if (value == 1) {
      _updategps(reportID);
    }
  });
}
