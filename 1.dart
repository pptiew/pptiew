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

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class _firstState extends State<first> {
  List<data> dataList = [];

  late DatabaseReference _dbref;
  String databasejson = '';

  late String heart = "beatavg";

  @override
  void initState() {
    super.initState();

    _dbref = FirebaseDatabase.instance.reference();
    _readdb_onechild();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildMain(),
    );
  }

  Widget buildMain() {
    return Container(
      child: Card(
        color: Color.fromARGB(255, 236, 228, 255),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                        colors: [Colors.white, Colors.blue.shade100])),
                margin: EdgeInsets.all(32),
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
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
                    StreamBuilder(
                        stream: _dbref.onValue,
                        builder:
                            (BuildContext context, AsyncSnapshot<Event> snap) {
                          if (snap.hasData &&
                              !snap.hasError &&
                              snap.data?.snapshot.value != null) {
                            Map data = snap.data?.snapshot.value;

                            data.forEach((key, value) {
                              // beatavg = data['beatavg'];
                              heart = value["beatavg"];
                              print("heart data : ${value["beatavg"]}");
                            });

                            //  var dd = data.entries.elementAt(0).value['key'];

                            // data.forEach((index, data) => item.add({"key": index, ...data}));
                            return Text(
                              "Heart Rate : ${heart}  Bpm",
                              // "Heart Rate : ${data.entries.elementAt(0).value['beatavg']}  Mph",
                              style: TextStyle(fontSize: 25),
                            );
                          } else {
                            return Center(child: Text("No data"));
                          }
                        }),
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
    );
  }

  _readdb_onechild() {
    _dbref
        .child("heart")
        .child("beatavg")
        .once()
        .then((DataSnapshot dataSnapshot) {
      print(" read once - " + dataSnapshot.value.toString());

      setState(() {
        heart = dataSnapshot.value.toString();
        databasejson = dataSnapshot.value.toString();
      });
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
          onPressed: () => {launch('tel:+${66626519422.toString()}')},
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
