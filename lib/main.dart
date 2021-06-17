import 'package:flutter/material.dart';
import 'clicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clicker',
      home: Clicker(),
    );
  }
}
