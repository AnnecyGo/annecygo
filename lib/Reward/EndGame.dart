import 'dart:math';
import 'rewardPage.dart';
import 'package:flutter/material.dart';
import '../WebSockets/wsCommunication.dart';

class EndGame extends StatefulWidget {
  final String winner;
  final int score;
  const EndGame(this.winner, this.score);

  @override
  _EndGameState createState() => _EndGameState();
}

class _EndGameState extends State<EndGame> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Fin de la partie !",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          backgroundColor: Colors.white,
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
                child: Text("Fin de la partie !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                    )),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(
                    widget.winner +
                        " gagne la partie avec " +
                        widget.score.toString() +
                        " points !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
