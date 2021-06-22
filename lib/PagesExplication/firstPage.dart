import 'package:flutter/material.dart';
import '../Settings/settings.dart';



class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
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
            _buildMessageStartUp(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.settings),
          onPressed: () =>
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Settings()),
            )
          }),
    );
  }


  Widget _buildMessageStartUp() {
    return new Flexible(
      child: Container(
          child: Text(
              "Pour commencer à utiliser l'application. Entrez un nom d'Utilisateur et commencez à accumuler des récompenses en explorant les monuments d'Annecy seul ou à plusieurs ! ",
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 40,
              ))
      ),
    );
  }
}