import 'package:flutter/material.dart';

class gps extends StatefulWidget {
  const gps({Key? key}) : super(key: key);

  @override
  _gpsState createState() => _gpsState();
}

class _gpsState extends State<gps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chronic Patient Emergency'),
        ),
        body: Container(
          color: Colors.blue[100],
          child: Center(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                        colors: [Colors.white, Colors.blue.shade100])),
                margin: EdgeInsets.all(32),
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage(
                        'image/hospital.png',
                      ),
                      width: 150,
                      height: 150,
                    ),
                    Text(
                      'Location',
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                )),
          ),
        ));
  }
}
