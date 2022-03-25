import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_more/Data.dart';
import 'package:flutter_application_more/long.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Data.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  _firstState createState() => _firstState();
}

class Activity extends State<first> {
  late Cubic static;
  final String heart = "beatavg";
  String? DatabaseReference;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _firstState extends State<first> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  List<data> dataList = [];
  final databaseReference = FirebaseDatabase.instance.reference();

  var mFirebaseDatabaseReference;

  get referenceData => null;

  @override
  void initState() {
    // TODO: implement build
    super.initState();
    final databaseRef = FirebaseDatabase.instance.reference();
    readData();

    databaseRef.child("heart");
    databaseReference.once().then((DataSnapshot heart) {
      dataList.clear();
      var keys = heart.value.beatavg;
      var values = heart.value;

      for (var beatavg in keys) {
        var data = heart.value![keys]['beatavg'].add(values);
      }
      setState(() {});
    });
  }

  void readData() async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child('heart');
    await databaseReference.once().then((DataSnapshot heart) {
      Map<dynamic, dynamic> values = heart.value;
      values.forEach((key, value) {
        print(value['beatavg']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {}

          return Scaffold(
              appBar: AppBar(
                title: Text('Chronic Patient Emergency'),
              ),
              body: Card(
                color: Color.fromARGB(255, 87, 16, 253),
                child: Center(
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(colors: [
                                Colors.white,
                                Colors.blue.shade100
                              ])),
                          margin: EdgeInsets.all(32),
                          padding: EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Image(
                                image: AssetImage(
                                  'image/heart-beat.png',
                                ),
                                width: 150,
                                height: 150,
                              ),
                              Text(
                                'beatavg',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Heart Rate : ${heart.value} Mph",
                                style: TextStyle(fontSize: 25),
                              ),
                              const Image(
                                image: AssetImage(
                                  'image/alert.png',
                                ),
                                width: 150,
                                height: 150,
                              ),
                              Buttoncall(),
                              Buttongps(),
                            ],
                          )),
                    ),
                  ),
                ),
              ));
        });
  }

  Container Buttoncall() {
    return Container(
        constraints: BoxConstraints.expand(height: 50),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.blue[200]),
        child: FlatButton(
          child: Text("Emergency Call!!!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          textColor: Colors.white,
          color: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () => {launch('tel:+${0626519422.toString()}')},
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container Buttongps() {
    return Container(
        constraints: BoxConstraints.expand(height: 50),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.blue[200]),
        child: FlatButton(
            child: Text("go to GPS",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            textColor: Colors.white,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditProfileSaler();
              }));
            }),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }
}
