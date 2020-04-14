import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NonEmergenciesPage extends StatefulWidget {
  @override
  _NonEmergenciesPageWidgetState createState() =>
      _NonEmergenciesPageWidgetState();
}

int _reportID;
String _service; //service selected in the drop down

class _NonEmergenciesPageWidgetState extends State<NonEmergenciesPage> {
  Position _userLocation;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myControllerName = TextEditingController();
    final myControllerNumber = TextEditingController();
    final myControllerAdditionalInformation = TextEditingController();
    return MaterialApp(
        home: Scaffold(
      //blue header
      appBar: AppBar(
        title: Text('Non-Emergencies Report'),
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
              "Please Select What Services are Required as well(Defaults to Fire, Police, and Medical)",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
            ),
            DropdownButton<String>(
              //Service drop down

              hint: Text('Please Choose One'),
              items: <String>[
                'None',
                'Medical',
                'Police',
                'Fire',
                'Fire and Medical',
                'Fire and Police',
                'Medical and Police'
              ].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String changed) {
                _service = changed;
                setState(() {});
              },
              value: _service,
            ),
            Text(
              "Please enter your name otherwise this will be submitted Anonymously",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
            ),
            TextFormField(
              controller: myControllerName,
              textAlign: TextAlign.left,
              autocorrect: false,
              showCursor: true,
              toolbarOptions: ToolbarOptions(
                cut: false,
                copy: false,
                selectAll: true,
                paste: false,
              ),
              decoration: new InputDecoration.collapsed(
                  hintText: "Please enter your name"),
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(45),
                WhitelistingTextInputFormatter(new RegExp(
                    '[A-Za-z\\s]')), //This will allow for letters and periods
                //BlacklistingTextInputFormatter(new RegExp('[\\,\\.]')), //This stops commas and periods
              ],
            ),
            Text(
              "Please submit your phone number(Not required)",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
            ),
            TextFormField(
              controller: myControllerNumber,
              textAlign: TextAlign.left,
              autocorrect: false,
              showCursor: true,
              keyboardType: TextInputType.number,
              toolbarOptions: ToolbarOptions(
                cut: false,
                copy: false,
                selectAll: true,
                paste: false,
              ),
              decoration: new InputDecoration.collapsed(
                  hintText: "Please enter phone number"),
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(14),
                WhitelistingTextInputFormatter.digitsOnly,
                //WhitelistingTextInputFormatter(new RegExp('[\\-,1,2,3,4,5,6,7,8,9,0]')) //This will allow for numbers and -
              ],
            ),
            Text(
              "Enter any additional information below",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
            ),
            TextFormField(
              controller: myControllerAdditionalInformation,
              textAlign: TextAlign.left,
              autocorrect: true,
              showCursor: true,
              toolbarOptions: ToolbarOptions(
                cut: false,
                copy: false,
                selectAll: true,
                paste: false,
              ),
              decoration: new InputDecoration.collapsed(
                  hintText:
                      "Enter any other information Enter any other information"),
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(256),
                WhitelistingTextInputFormatter(new RegExp(
                    '[A-Za-z\\.\\s]')), //This will allow for letters and periods
                //BlacklistingTextInputFormatter(new RegExp('[\\,]')), //This stops commas and periods
              ],
            ),
            Center(
              child: RaisedButton(
                child: Text('Submit'),
                onPressed: () {
                  _getLocation().then((value) {
                    setState(() {
                      _userLocation = value;
                    });
                  });
                  String encodeName;
                  String encodeNumber;
                  String encodedAdditional;
                  String encodedService;
                  String encodedReport;
                  String encodedLocation;
                  String encodedDateTime;
                  DateTime now = DateTime.now();
                  encodedDateTime =
                      DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
                  if (_service != null) {
                    if (_service == 'None') {
                      encodedService = "FPH";
                    } else if (_service == 'Medical') {
                      encodedService = "H";
                    } else if (_service == 'Police') {
                      encodedService = "P";
                    } else if (_service == 'Medical and Police') {
                      encodedService = "PH";
                    } else if (_service == 'Fire and Police') {
                      encodedService = "FP";
                    } else if (_service == 'Fire and Medical') {
                      encodedService = "FH";
                    }
                  } else {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // Retrieve the text the user has entered by using the
                          // TextEditingController.
                          content: Text('Please select a service required'),
                        );
                      },
                    );
                  }

                  if (myControllerName.text.toString() != "" ||
                      myControllerName.text.toString() != "\\+") {
                    encodeName = myControllerName.text;
                  } else {
                    encodeName = 'Annonymous';
                  }
                  if (myControllerNumber.text.toString() != "") {
                    encodeNumber = myControllerNumber.text;
                  } else {
                    encodeNumber = 'N/A';
                  }
                  if (myControllerAdditionalInformation.text.toString() != "") {
                    encodedAdditional = myControllerAdditionalInformation.text;
                  } else {
                    encodedAdditional = 'N/A';
                  }
                  encodedLocation = _userLocation.toString();
                  var values = {
                    "timestamp": encodedDateTime,
                    "required_responders": encodedService,
                    "status": "New",
                    "urgency": "High",
                    "GPS": encodedLocation,
                    "name": encodeName,
                    "phone": encodeNumber,
                    "photo": "Null",
                    "message": encodedAdditional,
                    "report_level": "Non Emergency",
                    "report_type": 'N/A'
                  };
                  final Json = json.encode(values);
                  _postReport(Json).then((reportIDValue) {
                    _reportID = reportIDValue;
                    print(_reportID);
                    Navigator.pop(context, _reportID);
                  });
                  //TODO Add Submission results later
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        // Retrieve the text the user has entered by using the
                        // TextEditingController.
                        content: Text(Json),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
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
