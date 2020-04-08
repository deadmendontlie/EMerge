import 'package:flutter/material.dart';

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
  int reportID = -1;
  bool reported = false;
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
                    reportID = newReportID;
                    print(reportID);
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
                    reportID = newReportID;
                    print(reportID);
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
                    reportID = newReportID;
                    print(reportID);
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
                    reportID = newReportID;
                    print(reportID);
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
                    reportID = newReportID;
                    print(reportID);
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
                  //TODO add code to check report statues and have it come up with a pop up
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
