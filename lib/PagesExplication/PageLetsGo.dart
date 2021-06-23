import 'package:annecygo/Login/login.dart';
import 'package:annecygo/Map/MainMap.dart';
import 'package:flutter/material.dart';

class GoPage extends StatefulWidget {

  @override
  _GoPageState createState() => _GoPageState();
}

class _GoPageState extends State<GoPage> {
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
        body: _contentWidget(),
      ),
    );
  }

  _contentWidget() {
    return new Scaffold(
      backgroundColor: Colors.redAccent,
      body: new Center(
        child: new Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
              Expanded(
                flex: 1,
                child:     Container(
                child: Text("But du jeu",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                    )),
              ),
              ),
              Expanded(
                flex: 7,
                child:
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child:
                Text("Pour gagner la partie, il faudra que tu passes par trois points différents qui sont des monuments d'Annecy.\n"
                    "Lorsque tu arrives vers un monument, un Quiz s'affiche sur ton smartphone, il faut répondre pour gagner des points.\n"
                    "Ces points t'aide à gagner un bon de réduction dans la liste des restaurants, bars et autres petits commerces partenaires.\n"
                    "Nous te laissons le choix du chemin à parcourir entrer les différents points, pour plus de liberté !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              ),
              Expanded(
                flex: 1,
                child:  Container(

                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                    "Que la partie commence !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    )
                ),
              ),),
              Expanded(
                flex: 1,
                child:
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0 , 20, 0),
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
                            )
                        )
                    ),
                    child: new Text(
                      "c'est parti",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                        fontSize: 40,
                      ),
                    ),
                    onPressed: _playPressed,
                  ),
                ),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _playPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapPage()),
    );
  }
}


