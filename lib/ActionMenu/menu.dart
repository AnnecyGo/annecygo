import 'package:annecygo/Style/Element.dart';
import 'package:annecygo/main.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'waitingRoom.dart';
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
      print("[Debug Menu] room: " + game.roomCode);
    } else {
      print("[Debug Menu] No room");
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
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => GenerateScreen()))
            .then((value) {});
        setState(() {});
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                            child: Container(
                              width: 120,
                              height: 120,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'images/AnnecyGO_logo.jpg',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              "Bienvenue " + game.playerName,
                              style: TextStyle(
                                  color: Color(0xFFEF3629),
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'images/transiBlancRouge.svg',
                          width: MediaQuery.of(context).size.width,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              color: Color(0xFFF12D37),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Je veux ...",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment(0, 0),
                                            child: CustomButton(
                                                text: "Créer",
                                                fontSize: 30,
                                                icon: Icons.add,
                                                onPressed: _createRoom),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment(0, 0),
                                            child: CustomButton(
                                                text: "Rejoindre",
                                                fontSize: 30,
                                                icon: Icons.qr_code_scanner,
                                                onPressed: _joinRoom),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text("une partie",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.w900)),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'images/transiRougeJaune.svg',
                          width: MediaQuery.of(context).size.width,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ],
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xFFF9B126),
                            borderRadius: BorderRadius.circular(0),
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _createRoom() {
    game.send('createNewGame', game.playerName);
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => GenerateScreen()))
        .then((value) {});
    ;
  }

  void _joinRoom() async {
    String codeScanner = await BarcodeScanner.scan();
    game.send('joinGame', {"name": game.playerName, "code": codeScanner});
  }
}
