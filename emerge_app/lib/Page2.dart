import 'package:flutter/material.dart';
class Page2 extends StatefulWidget{
  @override
  _Page2WidgetState createState() => _Page2WidgetState();

}

class _Page2WidgetState extends State<Page2> {
  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Page 2'),
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