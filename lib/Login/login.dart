import 'package:annecygo/Games/TrueFalsePage.dart';
import 'package:annecygo/Style/Element.dart';
import 'package:flutter/material.dart';
import 'package:annecygo/Map/MainMap.dart';
import '../ActionMenu/menu.dart';
import '../WebSockets/wsCommunication.dart';
import '../main.dart';
import '../Settings/settings.dart';

import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                              "Annecy GO",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: new Container(
                                            alignment: Alignment.centerLeft,
                                            decoration: new BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: new BorderRadius
                                                        .all(
                                                    new Radius.circular(23))),
                                            child: new Directionality(
                                                textDirection:
                                                    TextDirection.ltr,
                                                child: new TextField(
                                                  controller: _pseudoFilter,
                                                  autofocus: false,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 30.0,
                                                      color: Colors.white),
                                                  decoration:
                                                      new InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xFFF7898F),
                                                    hintText: 'Pseudo',
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 20.0,
                                                            bottom: 15.0,
                                                            right: 20.0,
                                                            top: 15.0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(
                                                              color: Colors
                                                                  .transparent),
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(23),
                                                    ),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(
                                                              color:
                                                                  Colors.red),
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(23),
                                                    ),
                                                  ),
                                                ))),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment(0, 0),
                                            child: CustomButton(
                                                text: "Jouer",
                                                onPressed: _playPressed),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
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

  final TextEditingController _pseudoFilter = new TextEditingController();
  String _pseudo = "";

  void _pseudoListen() {
    if (_pseudoFilter.text.isEmpty) {
      _pseudo = "";
    } else {
      _pseudo = _pseudoFilter.text;
    }
  }

  _LoginPageState() {
    _pseudoFilter.addListener(_pseudoListen);
  }

  Future<void> alertResult(String result) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Pseudo invalide',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(result),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                      fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _playPressed() {
    if (_pseudo != null && _pseudo != "") {
      game.setPlayerName(_pseudo);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ActionMenuPage()),
      );
    } else {
      alertResult("Veuillez renseigner un pseudo valide");
    }
  }
}
