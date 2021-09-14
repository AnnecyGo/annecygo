import 'package:flutter/material.dart';
import 'Games/TrueFalsePage.dart';
import 'Login/login.dart';
import 'Map/MainMap.dart';
import 'PagesExplication/firstPage.dart';
import 'WebSockets/wsCommunication.dart';
import 'WebSockets/config.dart';

ConfigApp configApp = new ConfigApp();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Annecy Go',
      theme: ThemeData(
        fontFamily: 'D DIN',
        primaryColor: Colors.white,
        accentColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          //headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold,fontFamily: 'Big Noodle'),
          //headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic,fontFamily: 'Big Noodle'),
          button: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      home: FirstPage(),
    );
  }
}
