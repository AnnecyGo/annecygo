import 'package:flutter/material.dart';
import 'Games/TrueFalsePage.dart';
import 'Login/login.dart';
import 'Map/MainMap.dart';
import 'WebSockets/wsCommunication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Annecy Go',
      theme: ThemeData(
        fontFamily: 'Big Noodle',
        primaryColor: Colors.white,
        accentColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          //headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold,fontFamily: 'Big Noodle'),
           //headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic,fontFamily: 'Big Noodle'),
           button: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      home: LoginPage(),
    );
  }
}
