import 'package:flutter/material.dart';
class Page4 extends StatefulWidget{
  @override
  _Page4WidgetState createState() => _Page4WidgetState();

}

class _Page4WidgetState extends State<Page4> {
  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Page 4'),
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