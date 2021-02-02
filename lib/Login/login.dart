import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Login Page',
      theme: new ThemeData(primarySwatch: Colors.red),
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
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
            Align(
              alignment: Alignment.center,
              child: _buildTextFields(),
            ),
            Align(
              alignment: Alignment.center,
              child: _buildButtons(),
            ),
          ],
        ),
      ),
    );
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

            child: new RaisedButton(

              color: Colors.white,
              child: new Text(
                'Login',
                style:
                TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black45,
                  fontSize: 40,
                ),
              ),
              onPressed: _loginPressed,
            ),
          ),),

          ButtonTheme(
            minWidth: 200.0,

            child: new RaisedButton(
              color: Colors.white,
              child: new Text(
                'Register',
                style:
                TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black45,
                  fontSize: 40,
                ),
              ),
              onPressed: _loginPressed,
            ),
          ),

        ],
      ),
    );
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed() {
    print('The user wants to login with $_email and $_password');
  }

  void _RegisterPressed() {
    print('The user wants to login with $_email and $_password');
  }
}
