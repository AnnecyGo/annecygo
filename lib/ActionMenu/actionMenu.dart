import 'package:annecygo/main.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'actionCreer.dart';
import '../WebSockets/wsCommunication.dart';
import '../WebSockets/wsNotifs.dart';

class ActionMenuPage extends StatefulWidget {
  @override
  _ActionMenuPageState createState() => _ActionMenuPageState();
}

class _ActionMenuPageState extends State<ActionMenuPage> {
  @override
  void initState() {
    if (game.roomCode != "") {
      print("room: " + game.roomCode);
    } else {
      print("########## no room");
    }
    super.initState();
    game.addListener(_onGameDataReceived);
  }

  @override
  void dispose() {
    game.removeListener(_onGameDataReceived);
    super.dispose();
  }

  _onGameDataReceived(message) {
    switch (message["action"]) {
      case "roomFound":
        // playersList = message["data"];
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => GenerateScreen()))
            .then((value) {
          print("here after push");
        });
        setState(() {});
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.fromLTRB(20, 70, 20, 50),
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: AlignmentDirectional(0.0, -3.0),
            image: AssetImage("images/background.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              'images/annecyGoTitle.png',
              fit: BoxFit.fitWidth,
            ),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return new Container(
      child: new Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 40.0),
            child: ButtonTheme(
              minWidth: 200.0,
              child: new ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(20, 10, 20, 10)),
                    minimumSize: MaterialStateProperty.all(Size(250.0, 20.0)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.white),
                    ))),
                child: new Text(
                  'CREER UNE PARTIE',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    fontSize: 40,
                  ),
                ),
                onPressed: () {
                  print("create game");
                  game.send('createNewGame', game.playerName);

                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GenerateScreen()))
                      .then((value) {
                    print("here after push");
                  });
                  ;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
              left: 20.0,
              right: 10.0,
              bottom: 150.0,
            ),
            child: ButtonTheme(
              minWidth: 200.0,
              child: new ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(20, 10, 20, 10)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    minimumSize: MaterialStateProperty.all(Size(250.0, 20.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.white),
                    ))),
                child: new Text(
                  'REJOINDRE UNE PARTIE',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    fontSize: 40,
                  ),
                ),
                onPressed: () async {
                  String codeScanner = await BarcodeScanner.scan();
                  print("join game");
                  print(codeScanner);
                  game.send('joinGame',
                      {"name": game.playerName, "code": codeScanner});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
