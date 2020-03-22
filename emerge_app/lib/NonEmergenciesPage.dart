import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NonEmergenciesPage extends StatefulWidget {
  @override
  _NonEmergenciesPageWidgetState createState() => _NonEmergenciesPageWidgetState();
}

class _NonEmergenciesPageWidgetState extends State<NonEmergenciesPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          //blue header
          appBar: AppBar(
            title: Text('NonEmergencies Report'),
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
                //TODO Remember later to center these and to add the scrolling functionality to the screen and put column inside it
                //TODO Also add the drop downs and stuff later
                //TODO Once this is all done and we have the http methods and stuff add them later and maybe have it make a json file on submit
                //TODO Add the drop down menus and fill them with info
                //TODO Make the text boxes nice and put extra info in them if needed
                //TODO Add other things need for the text boxes and drop downs
                //TODO Make the submit button work
                //TODO add a verification pop up before they submit the report
                //This pge will be able to send to medical fire and police as well but will be labelled differently
                Text(
                  "Please Select What Services are Required as well(Defaults to Just NonEmergencies)",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
                DropdownButton<String>(
                  hint: Text('No other Assistance is needed'),
                  items: <String>['Fire', 'Police', 'Fire and Police'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {},
                ),
                Text(
                  "Please Select Type of Report",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
                DropdownButton<String>(
                  hint: Text('No report type is selected'),
                  items: <String>['Heart Attack', 'Breathing Issue', 'Bleeding', 'Not clear'].map((String value) {
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
                      hintText: "Enter any other information Enter any other information"),
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
        ));
  }
}