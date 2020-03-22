import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirePage extends StatefulWidget {
  @override
  _FirePageWidgetState createState() => _FirePageWidgetState();
}

class _FirePageWidgetState extends State<FirePage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fire Page'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //TODO Add the drop down menus and fill them with info
              //TODO Make the text boxes nice and put extra info in them if needed
              //TODO Add other things need for the text boxes and drop downs
              //TODO Make the submit button work
              //TODO add a verification pop up before they submit the report
              Text(
                "Please Select What Services are Required as well(Defaults to Just Fire)",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
              DropdownButton<String>(
                hint: Text('No other Assistance is needed'),
                items: <String>['Medical', 'Police'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              Text(
                "Please Select What Services are Required",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
              DropdownButton<String>(
                hint: Text('No report type is selected'),
                items: <String>['Fire', 'Gas Leak', 'Figure out more'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              Text(
                "Please enter your name otherwise this will be submitted Anonymously",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
              TextFormField(
                textAlign: TextAlign.left,
                autocorrect: false,
                showCursor: true,
                decoration: new InputDecoration.collapsed(
                    hintText: "Please enter your name"),
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(256),
                  BlacklistingTextInputFormatter(new RegExp('[\\,]')),
                ],
              ),
              Text(
                "Please submit your phone number(Not required)",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
              TextFormField(
                textAlign: TextAlign.left,
                autocorrect: false,
                showCursor: true,
                decoration: new InputDecoration.collapsed(
                    hintText: "Please enter phone number"),
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(10),
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
              ),
              Text(
                "Enter any additional information below",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
              TextFormField(
                textAlign: TextAlign.left,
                autocorrect: true,
                showCursor: true,
                decoration: new InputDecoration.collapsed(
                    hintText: "Enter any other information (256 max)"),
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(256),
                  BlacklistingTextInputFormatter(new RegExp('[\\,]')),
                ],
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
      ),
    );
  }
}
