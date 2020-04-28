import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MedicalPage extends StatefulWidget {
  @override
  _MedicalPageWidgetState createState() => _MedicalPageWidgetState();
}

class _MedicalPageWidgetState extends State<MedicalPage> {
  Position _userLocation;
  @override
  initState() {
    super.initState();
  }

  int _reportID;
  String _service; //service selected in the drop down
  String _report; //what type of report is selected
  @override
  Widget build(BuildContext context) {
    final myControllerName = TextEditingController();
    final myControllerNumber = TextEditingController();
    final myControllerAdditionalInformation = TextEditingController();
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Color(0xFF2d3447),

      //blue header
      appBar: AppBar(
        backgroundColor: Color(0xFF2D3439),
        title: Text('Medical Report'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          tooltip: 'Back',
          onPressed: () {
            //Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            //TODO Clean up all of the text and add all of the proper report types
            //TODO add a verification pop up before they submit the report
            //TODO Remove the dialog at the end when this is done
            Text(
              "Please Select What Services are Required as well(Defaults to Just Medical)",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
            DropdownButton<String>(
              hint: Text(
                'Please Choose One',
                style: TextStyle(color: Colors.white),
              ),
              items: <String>['None', 'Fire', 'Police', 'Fire and Police']
                  .map((String value) {
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
            ), //DropdownButton
            Text(
              "Please Select Type of Report",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
            DropdownButton<String>(
              hint: Text(
                'No report type is selected',
                style: TextStyle(color: Colors.white),
              ),
              items: <String>[
                'Heart Attack',
                'Breathing Issue',
                'Bleeding',
                'Not clear'
              ].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(
                    value,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (String changed) {
                _report = changed;
                setState(() {});
              },
              value: _report,
            ), //DropdownButton
            Text(
              "Please enter your name otherwise this will be submitted Anonymously",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
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
              style: TextStyle(color: Colors.white),
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(45),
                WhitelistingTextInputFormatter(new RegExp(
                    '[A-Za-z\\s]')), //This will allow for letters and periods
                //BlacklistingTextInputFormatter(new RegExp('[\\,\\.]')), //This stops commas and periods
              ],
            ),
            Text(
              "Please submit your phone number(Not required)",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
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
              style: TextStyle(color: Colors.white),
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(14),
                WhitelistingTextInputFormatter.digitsOnly,
                //WhitelistingTextInputFormatter(new RegExp('[\\-,1,2,3,4,5,6,7,8,9,0]')) //This will allow for numbers and -
              ],
            ),
            Text(
              "Enter any additional information below",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
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
              style: TextStyle(color: Colors.white),
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(256),
                WhitelistingTextInputFormatter(new RegExp(
                    '[A-Za-z\\.\\s]')), //This will allow for letters, spaces, and periods
                //BlacklistingTextInputFormatter(new RegExp('[\\,]')), //This stops commas and periods
              ],
            ),
            Center(
              child: RaisedButton(
                padding: new EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.red)),
                child: Text('Submit'),
                onPressed: () async {
                  _userLocation = await _getLocation() as Position;
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
                      encodedService = "H";
                    } else if (_service == 'Fire') {
                      encodedService = "FH";
                    } else if (_service == 'Police') {
                      encodedService = "PH";
                    } else if (_service == 'Fire and Police') {
                      encodedService = "FPH";
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
                  if (_report == null) {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // Retrieve the text the user has entered by using the
                          // TextEditingController.
                          content: Text('Please select a report type'),
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
                  encodedReport = _report;
                  encodedLocation = _userLocation.toString();
                  var values = {
                    "timestamp": encodedDateTime,
                    "required_responders": encodedService,
                    "status": "New",
                    "urgency": "High",
                    "GPS": encodedLocation,
                    "name": encodeName,
                    "phone": encodeNumber,
                    "photo": null,
                    "message": encodedAdditional,
                    "report_level": "Emergency",
                    "report_type": encodedReport
                  };
                  final Json = json.encode(values);
                  _postReport(Json).then((reportIDValue) {
                    _reportID = reportIDValue;
                    print(_reportID);
                    Navigator.pop(context, _reportID);
                  });
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        // Retrieve the text the user has entered by using the
                        // TextEditingController.
                        content: Text(Json + "\nYour report was submitted"),
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
