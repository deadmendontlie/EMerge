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
  String text = "text";
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
                  // Navigate to the second screen using a named route
                  _navigateToMedicalPage(context);
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Police'),
                onPressed: () {
                  // Navigate to the second screen using a named route
                  //Navigator.pushNamed(context, '/PolicePage');
                  _navigateToPolicePage(context);
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Fire'),
                onPressed: () {
                  // Navigate to the second screen using a named route
                  //Navigator.pushNamed(context, '/FirePage');
                  _navigateToFirePage(context);
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Tips'),
                onPressed: () {
                  // Navigate to the second screen using a named route
                  //Navigator.pushNamed(context, '/TipsPage');
                  _navigateToTipsPage(context);
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Non-Emergencies'),
                onPressed: () {
                  //TODO add a non-emergencies page and copy all of the code over
                  // Navigate to the second screen using a named route
                  //Navigator.pushNamed(context, '/NonEmergenciesPage');
                  _navigateToNonEmergenciesPage(context);
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

  void _navigateToMedicalPage(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.pushNamed(context, '/MedicalPage');
  }

  void _navigateToFirePage(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.pushNamed(context, '/FirePage');
  }

  void _navigateToNonEmergenciesPage(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.pushNamed(context, '/NonEmergenciesPage');
  }

  void _navigateToPolicePage(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.pushNamed(context, '/PolicePage');
  }

  void _navigateToTipsPage(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.pushNamed(context, '/TipsPage');
  }
}
