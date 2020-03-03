import 'package:flutter/material.dart';
class Page3 extends StatefulWidget{
  @override
  _Page3WidgetState createState() => _Page3WidgetState();

}

class _Page3WidgetState extends State<Page3> {
  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Page 3'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }


}