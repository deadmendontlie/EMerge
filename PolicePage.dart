import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PolicePage extends StatefulWidget {
  @override
  _PolicePageWidgetState createState() => _PolicePageWidgetState();
}

class _PolicePageWidgetState extends State<PolicePage> {
  @override
  initState() {
    super.initState();
  }

  String service; //service selected in the drop down
  String report;  //what type of report is selected

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Police Report'),
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
                "Please Select What Services are Required as well(Defaults to Just Police)",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
              DropdownButton<String>(
                hint: Text('Please Choose One'),
                items: <String>['None','Fire', 'Medical', 'Figure out more and change previous'].map((String value) {
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
              ),
              Text(
                "Please Select Type of Report",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
              DropdownButton<String>(
                hint: Text('No report type is selected'),
                items: <String>['Fire', 'Medical'].map((String value) {
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
              ),
              Text(
                "Please enter your name otherwise this will be submitted Anonymously",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
              TextFormField(
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
                  WhitelistingTextInputFormatter(new RegExp('[A-Za-z\\s]')), //This will allow for letters and periods
                  //BlacklistingTextInputFormatter(new RegExp('[\\,]')), //This stops commas and periods
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
                    hintText: "Enter any other information (256 max)"),
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(256),
                  WhitelistingTextInputFormatter(new RegExp('[A-Za-z\\.\\s]')), //This will allow for letters and periods
                  //BlacklistingTextInputFormatter(new RegExp('[\\,\\.]')), //This stops commas and periods
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
