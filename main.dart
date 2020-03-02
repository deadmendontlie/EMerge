import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'customicons.dart';
import 'data.dart';
import 'dart:math';
import 'dart:io';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:queries/collections.dart';
import 'package:enumerable/enumerable.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';


void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

//ratio of the cards
var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _MyAppState extends State<MyApp> {
  //permission status
  PermissionStatus _status;
  //Gallery and Camera
  File imageFile;
  _detect(BuildContext context) async{
    print(imageFile);
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();

    List<ImageLabel> labels = await labeler.processImage(visionImage);

    for (ImageLabel label in labels) {
      final String text = label.text;
      final String entityId = label.entityId;
      final double confidence = label.confidence;
      print(text);
      print(entityId);
      print(confidence);
    }



  }

  //gallery and camera perms and picking
  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }//open photo gallery
  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }//open camera
  @override
  void initState() {
    super.initState();
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse)
        .then(_updateStatus);
  }//checks perms

  /*
  Pick Camera or roll dialog
   */
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Make a choice'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("gallary"),
                    onTap: () {
                      _askPermission(1);
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("camera"),
                    onTap: () {
                      _askPermission(2);
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }



  var currentPage = listOfPictures.distinct().toList().length - 1.0;

  @override
  Widget build(BuildContext context) {
    //PageController controller = PageController(initialPage: images.length - 1);
    PageController controller = PageController(
        initialPage: listOfPictures.distinct().toList().length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
/*
return SafeArea()
*/
    return Scaffold(
      //change background color
      backgroundColor: Color(0xFF2d3447),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  //move to position
                  left: 12.0,
                  right: 12.0,
                  top: 30.0,
                  bottom: 8.0),
              child: Row(
                  //here xxxxxxxx here
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        //menu
                        CustomIcons.menu,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        //search
                        Icons.search,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    )
                  ]),
            ),
            //text Stuff for "take pic"

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Take Picture",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 46.0,
                        fontFamily: "Calibre-Semibold",
                        letterSpacing: 1.0,
                      )),
                  IconButton(
                    icon: Icon(
                      Icons.camera,
                      size: 40.0,
                      color: Colors.purpleAccent,
                    ),
                    onPressed: () {
                      _showChoiceDialog(context);
                    },
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFff6e6e),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 6.0),
                        child: Text(
                          "Raw Pictures",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text("+5 Pictures",
                      style: TextStyle(color: Colors.blueAccent))
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                CardScrollWidget(currentPage),
                _decideImageView(),
                Positioned.fill(
                  child: PageView.builder(
                    //itemCount images.length,
                    itemCount: listOfPictures.length,
                    controller: controller,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Container();
                    },
                  ),
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("ML Model",
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 46.0,
                        fontFamily: "Calibre-Semibold",
                        letterSpacing: 1.0,
                      )),
                  IconButton(
                    icon: Icon(
                      CustomIcons.option,
                      size: 12.0,
                      color: Colors.white,
                    ),
                    onPressed: () {


                     _detect(context);

                    },
                  )
                ],
              ),
            ),

      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 6.0),
                  child: Text("Processed Images",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text("2+ Images",
                style: TextStyle(color: Colors.blueAccent))
          ],
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset("assets/image_02.jpg",
                  width: 296.0, height: 222.0),
            ),
          )
        ],
      )
          ],
        ),
      ),
    );
  }







  //Displays image to screen
  Widget _decideImageView() {
    if (imageFile == null) {
      return Text(" ");
    } else {
      listOfPictures.add(imageFile.path);
      return Image.file(imageFile, width: 0, height: 0);
    }
  }

  //perm stuff for camera and photos
  void _askPermission(int number) {
    if (number == 1) {
      PermissionHandler().requestPermissions([PermissionGroup.photos]).then(
          _onStatusRequested);
    } else if (number == 2) {
      PermissionHandler().requestPermissions([PermissionGroup.camera]).then(
          _onStatusRequested);
    }
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
      });
    }
  }

  void _onStatusRequested(
    Map<PermissionGroup, PermissionStatus> statuses,
  ) {
    var status1 = statuses[PermissionGroup.photos];
    var status2 = statuses[PermissionGroup.camera];

    if (status1 == PermissionStatus.granted) {
      _updateStatus(status1);
    } else if (status2 == PermissionStatus.granted) {
      _updateStatus(status2);
    } else {
      print('big broke');
      PermissionHandler().openAppSettings();
    }
  }


} //state Class

//scrollable cards
// ignore: must_be_immutable
class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;
  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        //for(var i = 0; i< images.length;i++){

        var query = listOfPictures.distinct().toList();

        for (var i = 0; i < query.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;
          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);
          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: AspectRatio(
              aspectRatio: cardAspectRatio,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  //Image.asset(images[i],fit: BoxFit.cover)
                  Image.asset(query[i], fit: BoxFit.cover)
                ],
              ),
            ),
          );

          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
