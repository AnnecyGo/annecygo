import 'dart:math';
import '../Reward/rewardPage.dart';
import 'package:flutter/material.dart';
import '../WebSockets/wsCommunication.dart';

class TrueFalsePage extends StatefulWidget {
  final Map<String, dynamic> currentQuestion;
  final String monumentId;
  const TrueFalsePage(this.monumentId, this.currentQuestion);

  @override
  _TrueFalsePageState createState() => _TrueFalsePageState();
}

class _TrueFalsePageState extends State<TrueFalsePage> {
  @override
  void initState() {
    game.addListener(_onGameDataReceived);
    super.initState();
  }

  @override
  void dispose() {
    game.removeListener(_onGameDataReceived);
    super.dispose();
  }

  _onGameDataReceived(message) {
    switch (message["action"]) {
      case "refreshPlayersPosition":
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.currentQuestion);
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Vrai ou Faux ?",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          backgroundColor: Colors.red,
        ),
        body: _contentWidget(),
      ),
    );
  }

  _contentWidget() {
    return new Scaffold(
      backgroundColor: Colors.redAccent,
      body: new Center(
        child: new Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.5,
                0.5,
              ],
              colors: [
                Colors.red,
                Colors.redAccent,
              ],
            ),
          ),
          margin: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(widget.currentQuestion["question"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                    )),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0.5,
                          0.5,
                        ],
                        colors: [
                          Colors.greenAccent,
                          Colors.green,
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(40, 10, 40, 10)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black),
                            ))),
                        child: new Text(
                          'VRAI',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontSize: 36,
                          ),
                        ),
                        onPressed: () => answerValidation(true)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0.5,
                          0.5,
                        ],
                        colors: [
                          Colors.redAccent,
                          Colors.red,
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(40, 10, 40, 10)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black),
                            ))),
                        child: new Text(
                          'FAUX',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontSize: 36,
                          ),
                        ),
                        onPressed: () => answerValidation(false)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> alertResult(String title, String comment) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  comment,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
                game.send("newUserScore", {
                  "room": game.roomCode,
                  "id": game.playerId,
                  "monumentId": widget.monumentId
                });
              },
            ),
          ],
        );
      },
    );
  }

  void answerValidation(bool userAnswer) {
    if (widget.currentQuestion["answer"] == userAnswer) {
      alertResult(
          "Bravo c'est une bonne réponse", widget.currentQuestion["comment"]);
      /*Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RewardPage()));*/
    } else {
      alertResult("C'est perdu dommage", widget.currentQuestion["comment"]);
    }
  }
}
