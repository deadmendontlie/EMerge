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

  String service; //service selected in the drop down
  String report;  //what type of report is selected

  @override
  Widget build(BuildContext context) {
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
                  hint: Text('Please Choose One'),
                  items: <String>['None','Fire', 'Police', 'Medical', 'Fire and Police',
                  'Fire and Medical', 'Police and Medical'].map((String value) {
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
                      hintText: "Enter any other information"),
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(256),
                    WhitelistingTextInputFormatter(new RegExp('[A-Za-z\\.\\s]')), //This will allow for letters and periods
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
        ));
  }
}