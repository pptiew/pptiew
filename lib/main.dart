import 'package:flutter/material.dart';
import 'package:flutter_application_more/1.dart';
import 'package:flutter_application_more/register.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chronic Patient Emergency',
      home: login(),
    );
  }
}
