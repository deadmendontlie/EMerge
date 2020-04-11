import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
                  //TODO Have it setup so the values are not hardcoded
                  //TODO Also have it return back when the submit button is hit
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
                  //TODO add a non-emergencies page and copy all of the code over
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
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Report Status'),
                onPressed: () {
                  if (_reportID != -1) {
                    //TODO add code to check report statues and have it come up with a pop up
                    _fetchStatus().then((reportStatus) {
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
      status: json['test'],
    );
  }
  String get getStatus {
    return status;
  }
}

Future<String> _fetchStatus() async {
  //TODO change it from test to the proper end point and make it a post
  //TODO Also test it with the new end point and values
  final response = await http.get('http://18.212.156.43:80/test');
  if (response.statusCode == 200) {
    return Status.fromJson(json.decode(response.body)).getStatus;
  } else {
    throw Exception('Currently no active reports');
  }
}
