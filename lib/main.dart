import 'package:flutter/material.dart';
import 'Games/TrueFalsePage.dart';
import 'Login/login.dart';
import 'Map/MainMap.dart';
import 'WebSockets/wsCommunication.dart';

GameCommunication communication = new GameCommunication();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Annecy Go',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: LoginPage(),
    );
  }
}
