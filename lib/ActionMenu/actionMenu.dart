import 'package:flutter/material.dart';

import 'actionCreer.dart';
import 'actionRejoindre.dart';

void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Page Action Menu';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: new ThemeData(primarySwatch: Colors.red, fontFamily: 'BigNoodleTitiling'),
      home: new ActionMenuPage(),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class ActionMenuPage extends StatelessWidget {
  ActionMenuPage({Key key}) : super(key: key);

  Future navigateToActionCreer(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GenerateScreen()));
  }

  Future navigateToActionRejoindre(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ScanQR()));
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container (
        padding: EdgeInsets.all(50.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0, -5),
            image: AssetImage("images/background.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'images/annecyGoTitle.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  navigateToActionCreer(context);
                },
                child: const Text('CREER', style: TextStyle(fontSize: 20,
                    fontFamily: 'BigNoodleTitling',
                    fontStyle: FontStyle.italic)),
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  navigateToActionRejoindre(context);
                },
                child: const Text('REJOINDRE', style: TextStyle(fontSize: 20,
                    fontFamily: 'BigNoodleTitling',
                    fontStyle: FontStyle.italic)),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}