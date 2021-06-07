import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import '../main.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  TextEditingController _ipController =
      new TextEditingController(text: configApp.ip);
  TextEditingController _portController =
      new TextEditingController(text: configApp.port);

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
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(context),
          ),
          centerTitle: true,
          title: Text(
            "App Settings",
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

  Widget _settingsList() {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "IP : ",
              style: new TextStyle(fontSize: 25),
            ),
            Container(
              width: 230,
              constraints: BoxConstraints(minWidth: 230.0, minHeight: 25.0),
              child: TextField(
                controller: _ipController,
              ),
            )
          ],
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "PORT : ",
              style: new TextStyle(fontSize: 25),
            ),
            Container(
              width: 230,
              constraints: BoxConstraints(minWidth: 230.0, minHeight: 25.0),
              child: TextField(
                controller: _portController,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
              child: new Text(
                'SAUVEGARDER',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                  fontSize: 40,
                ),
              ),
              onPressed: () => {_saveSettings()},
            )
          ],
        )
      ],
    ));
  }

  _saveSettings() {
    configApp.ip = _ipController.text;
    configApp.port = _portController.text;
    Navigator.of(context).pop(context);
  }

  _contentWidget() {
    return Container(
        color: const Color(0xFFFFFFFF),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(bottom: 20, top: 20, right: 20, left: 20),
                  child: new Column(
                    children: <Widget>[
                      new Text(
                        'Paramètres serveur:',
                        style: new TextStyle(fontSize: 40),
                      ),
                      _settingsList(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
