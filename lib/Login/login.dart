import 'package:annecygo/Games/TrueFalsePage.dart';
import 'package:flutter/material.dart';
import 'package:annecygo/Map/MainMap.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// Used for controlling whether the user is loging or creating an account
enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.fromLTRB(20,70,20,50),
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0, 10),
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

  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType
      .login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }


  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(labelText: 'Email'),
            ),
          ),
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return new Container(

      child: new Column(

        children: <Widget>[

          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child:ButtonTheme(
            minWidth: 200.0,

            child: new ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(20,10,20,10)),
                  minimumSize: MaterialStateProperty.all(Size(250.0,20.0)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white) ,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.white),

                      )
                  )
              ),
              child: new Text(
                'LOGIN',
                style:
                TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                  fontSize: 40,
                ),
              ),
              onPressed: _loginPressed,
            ),
          ),),

          ButtonTheme(
            minWidth: 200.0,

            child: new ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(20,10,20,10)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white) ,
                  minimumSize: MaterialStateProperty.all(Size(250.0,20.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.white),
                      )
                  )
              ),
              child: new Text(
                'REGISTER',
                style:
                TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                  fontSize: 40,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrueFalsePage()),
                );},
            ),
          ),

        ],
      ),
    );
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed() {
    print('The user wants to login with $_email and $_password');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapPage()),
    );
  }

  void _RegisterPressed() {
    print('The user wants to login with $_email and $_password');
  }
}
