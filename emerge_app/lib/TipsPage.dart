import 'package:flutter/material.dart';
class TipsPage extends StatefulWidget{
  @override
  _TipsPageWidgetState createState() => _TipsPageWidgetState();

}

class _TipsPageWidgetState extends State<TipsPage> {
  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Anonymous Tips'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Text(
              "Please Select What Services are Required",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Please select the type of activity.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Please enter a description of the activity.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Please enter your name otherwise this will be submitted Anonymously",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Please submit your phone number(Not required)",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),

            Center(
              child: RaisedButton(
                child: Text('Submit'),
                onPressed: () {
                  // Add Submission results later

                },
              ),
            ),
          ],
        ),

      ),
    );
  }


}