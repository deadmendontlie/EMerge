import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

//TODO Look into changing this to stateful or look into local fle parsing
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
  int _reportID = -1;
  bool _reported = false;
  String _currentReportStatus;
  bool _emergencyReport = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Start Screen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: RaisedButton(
                child: Text('Medical'),
                onPressed: () {
                  //Returns a value currently when the function ends
                  //TODO Copy all of the submoitting reports code to here and other pages
                  //TODO Put the writes in here and check to see if something was already written to the file
                  _navigateToMedicalPage(context).then((newReportID) {
                    _reportID = newReportID;
                    print(_reportID);
                    if (_reportID != -1) {
                      _reported = true;
                    }
                  });
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Police'),
                onPressed: () {
                  //Returns a value currently when the function ends
                  _navigateToPolicePage(context).then((newReportID) {
                    _reportID = newReportID;
                    print(_reportID);
                    if (_reportID != -1) {
                      _reported = true;
                    }
                  });
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Fire'),
                onPressed: () {
                  //Returns a value currently when the function ends
                  _navigateToFirePage(context).then((newReportID) {
                    _reportID = newReportID;
                    print(_reportID);
                    if (_reportID != -1) {
                      _reported = true;
                    }
                  });
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Tips'),
                onPressed: () {
                  //Returns a value currently when the function ends
                  _navigateToTipsPage(context).then((newReportID) {
                    _reportID = newReportID;
                    print(_reportID);
                    if (_reportID != -1) {
                      _reported = true;
                    }
                  });
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Non-Emergencies'),
                onPressed: () {
                  //Returns a value currently when the function ends
                  _navigateToNonEmergenciesPage(context).then((newReportID) {
                    _reportID = newReportID;
                    print(_reportID);
                    if (_reportID != 1) {
                      _reported = true;
                    }
                  });
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Emergency'),
                onPressed: () {
                  //TODO add code to submit an emergency report
                  _postEmergency().then((onValue) {
                    _reportID = onValue;
                    if (_reportID != -1) {
                      _reported = true;
                      _emergencyReport = true;
                    }
                    print(_reportID);
                  });
                  _emergencyReport = true;
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Report Status'),
                onPressed: () {
                  print(_reportID);
                  if (_reportID != -1) {
                    //TODO Finish report status to actually get a report
                    _fetchStatus(_reportID).then((reportStatus) {
                      _currentReportStatus = reportStatus;
                      print(_currentReportStatus);
                      if (_currentReportStatus != 'Closed') {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              // Retrieve the text the user has entered by using the
                              // TextEditingController.
                              content: Text(
                                  'Report Status is ' + _currentReportStatus),
                            );
                          },
                        );
                      } else {
                        if (_reported == true) {
                          _reported = false;
                          _reportID = -1;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                // Retrieve the text the user has entered by using the
                                // TextEditingController.
                                content: Text(
                                    'Your report was closed and or solved'),
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                // Retrieve the text the user has entered by using the
                                // TextEditingController.
                                content: Text(
                                    'Your report was closed or you have no active reports'),
                              );
                            },
                          );
                        }
                      }
                    });
                  }
                },
              ),
            ),
          ],
        ));
  }

  Future<int> _navigateToMedicalPage(BuildContext context) async {
    return await Navigator.pushNamed(context, '/MedicalPage') as int;
  }

  Future<int> _navigateToFirePage(BuildContext context) async {
    return await Navigator.pushNamed(context, '/FirePage') as int;
  }

  Future<int> _navigateToNonEmergenciesPage(BuildContext context) async {
    return await Navigator.pushNamed(context, '/NonEmergenciesPage') as int;
  }

  Future<int> _navigateToPolicePage(BuildContext context) async {
    return await Navigator.pushNamed(context, '/PolicePage') as int;
  }

  Future<int> _navigateToTipsPage(BuildContext context) async {
    return await Navigator.pushNamed(context, '/TipsPage') as int;
  }
}

class Status {
  //TODO Change the value of the json from test to whatever it needs to be to get status
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

Future<String> _fetchStatus(int id) async {
  //TODO change it from test to the proper end point and make it a post or whatever
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

void _updategps(int id) async {
  final reportStatus = _fetchStatus(id);
  if (reportStatus != 'Closed') {
    final location = await _getLocation();
    var value = {"report_id": id, "GPS": location.toString()};
    final Json = json.encode(value);
    //TODO need to submit the json here
    final response = await http.put('http://18.212.156.43:80/change_report_gps',
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: Json);
    if (response.statusCode == 200) {
      print('It worked');
    } else {
      throw Exception('Failed to update gps');
    }
  } else {
    throw Exception('No active report');
  }
}

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
    print(response.statusCode);
    throw Exception('Report was not submitted');
  }
}

//TODO Add a timer function to run every minute
//TODO Add a emergency submission function

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
  _postReport(Json).then((reportIDValue) {
    print(reportIDValue);
    return reportIDValue;
  });
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/info.txt');
}

//TODO Add the access and writing operations to the file for the data
//TODO Add the checks to lock them out of submitting new reports till theirs is done
//TODO Also change all of the check to check from the file
//File formatting should be as such reportID:1231432523 reportStatus:Closed
Future<void> _writeDataToFile(String info) async {
  File file = await _localFile;
  file.writeAsStringSync(info);
}

Future<int> _getReportID(String data) async {
  File file = await _localFile;
  String infoPreParsed = file.readAsStringSync();
  return int.parse(infoPreParsed.split(' ').first.split(':').last);
}

Future<String> _getReportStatus(String data) async {
  File file = await _localFile;
  String infoPreParsed = file.readAsStringSync();
  return infoPreParsed.split(' ').last.split(':').last;
}
