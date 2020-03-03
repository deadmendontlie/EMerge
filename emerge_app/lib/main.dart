import 'package:flutter/material.dart';
import 'MedicalPage.dart';
import 'PolicePage.dart';
import 'FirePage.dart';
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
    });
  }
}

class StartScreen extends StatelessWidget {

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
                child: Text('MedicalPage'),
                onPressed: () {
                  // Navigate to the second screen using a named route
                  Navigator.pushNamed(context, '/MedicalPage');
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('PolicePage'),
                onPressed: () {
                  // Navigate to the second screen using a named route
                  Navigator.pushNamed(context, '/PolicePage');
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('FirePage'),
                onPressed: () {
                  // Navigate to the second screen using a named route
                  Navigator.pushNamed(context, '/FirePage');
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('TipsPage'),
                onPressed: () {
                  // Navigate to the second screen using a named route
                  Navigator.pushNamed(context, '/TipsPage');
                },
              ),
            ),
          ],
        ));
  }
}
