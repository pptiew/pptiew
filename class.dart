import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_more/Data.dart';

class readdata extends StatefulWidget {
  const readdata({Key? key}) : super(key: key);

  @override
  State<readdata> createState() => _readdataState();
}

class _readdataState extends State<readdata> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  @override
  void initState() {
    // TODO: implement build
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("eiei"),
      ),
      body: Text('beatavg'),
    );
  }
}
