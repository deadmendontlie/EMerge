import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TipsPage extends StatefulWidget {
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
          title: Text('Tips'),
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
                  WhitelistingTextInputFormatter(new RegExp(
                      '[A-Za-z\\s]')), //This will allow for letters only
                  //BlacklistingTextInputFormatter(new RegExp('[\\,\\.]')), //This stops commas and periods
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
                "Enter what you would like to report for the tip.",
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
                    hintText: "Tip Information (256 max)"),
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
