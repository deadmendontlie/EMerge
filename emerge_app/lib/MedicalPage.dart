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
  Geolocator geolocator = Geolocator();
  Position userLocation;
  @override
  initState() {
    super.initState();
  }

  int reportID;
  String service; //service selected in the drop down
  String report; //what type of report is selected
  @override
  Widget build(BuildContext context) {
    final myControllerName = TextEditingController();
    final myControllerNumber = TextEditingController();
    final myControllerAdditionalInformation = TextEditingController();
    return MaterialApp(
        home: Scaffold(
      //blue header
      appBar: AppBar(
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
            Text(
              "Please Select What Services are Required as well(Defaults to Just Medical)",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
            ),
            DropdownButton<String>(
              hint: Text('Please Choose One'),
              items: <String>['None', 'Fire', 'Police', 'Fire and Police']
                  .map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String changed) {
                service = changed;
                setState(() {});
              },
              value: service,
            ), //DropdownButton
            Text(
              "Please Select Type of Report",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
            ),
            DropdownButton<String>(
              hint: Text('No report type is selected'),
              items: <String>[
                'Heart Attack',
                'Breathing Issue',
                'Bleeding',
                'Not clear'
              ].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String changed) {
                report = changed;
                setState(() {});
              },
              value: report,
            ), //DropdownButton
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
                    '[A-Za-z\\.\\s]')), //This will allow for letters, spaces, and periods
                //BlacklistingTextInputFormatter(new RegExp('[\\,]')), //This stops commas and periods
              ],
            ),
            Center(
              child: RaisedButton(
                child: Text('Submit'),
                onPressed: () {
                  _getLocation().then((value) {
                    setState(() {
                      userLocation = value;
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
                  if (service == 'None') {
                    encodedService = "H";
                  } else if (service == 'Fire') {
                    encodedService = "FH";
                  } else if (service == 'Police') {
                    encodedService = "PH";
                  } else if (service == 'Fire and Police') {
                    encodedService = "FPH";
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
                  encodedReport = report;
                  encodedLocation = userLocation.toString();
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
                    "report_level": "Emergency",
                    "report_type": encodedReport
                  };
                  final Json = json.encode(values);
                  _postReport(Json).then((reportIDValue) {
                    reportID = reportIDValue;
                    print(reportID);
                    Navigator.pop(context, reportID);
                  });
                  //TODO Remove the dialog when this is done
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
