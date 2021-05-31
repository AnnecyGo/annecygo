import 'package:annecygo/Games/TrueFalsePage.dart';
import 'package:flutter/material.dart';
import 'package:annecygo/Map/MainMap.dart';
import '../ActionMenu/actionMenu.dart';
import '../WebSockets/wsCommunication.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => alertStartUp());
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
            _buildTextFields(),
            _buildButtons(),
          ],
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

  Widget _buildTextFields() {
    return new Container(
      child: new Container(
        child: new TextField(
          controller: _pseudoFilter,
          decoration: new InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(100.0),
                ),
              ),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey[800]),
              labelText: "Pseudo",
              fillColor: Colors.white54),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return new Container(
      child: new Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
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
                  'JOUER',
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
        ],
      ),
    );
  }

  Future<void> alertStartUp() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bienvenue dans Annecy Go'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    "Pour commencer à utiliser l'application. Entrez un nom d'Utilisateur et commencez à accumuler des récompenses en explorant les monuments d'Annecy ! "),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> alertResult(String result) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pseudo incorrect'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(result),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

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
