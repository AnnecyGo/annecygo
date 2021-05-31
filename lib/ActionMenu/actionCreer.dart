import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import '../Map/MainMap.dart';
import '../WebSockets/wsCommunication.dart';

class GenerateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  String _dataString = "";
  String _inputErrorText = "";
  final TextEditingController _textController = TextEditingController();

  List<dynamic> playersList = <dynamic>[];

  Future navigateToMap(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
  }

  @override
  void initState() {
    super.initState();
    game.addListener(_onGameDataReceived);
    game.send('getPlayerList', null);
    if (game.roomCode != "") {
      game.send('getPlayerList', game.roomCode);
    }
  }

  @override
  void dispose() {
    game.removeListener(_onGameDataReceived);
    super.dispose();
  }

  _onGameDataReceived(message) {
    switch (message["action"]) {
      case "generate_qr":
        print(message["data"]["code"]);
        _dataString = message["data"]["code"];
        break;

      case "players_list":
        playersList = message["data"];
        print("############");
        print("############");
        print("PLAYER LIST");
        print(playersList);
        print("############");
        print("############");
        setState(() {});
        break;

      /* case 'new_game':
        Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) => new GamePage(
                opponentName: message["data"], // Name of the opponent
                character: 'O',
              ),
            ));
        break;*/
    }
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
            "Room: " + game.roomCode,
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

  Widget _playersList() {
    print(playersList);

    List<Widget> children = playersList.map((playerInfo) {
      return new ListTile(
        title: new Text(playerInfo["name"]),
        trailing: new RaisedButton(
          onPressed: () {
            // _onPlayGame(playerInfo["name"], playerInfo["id"]);
          },
          child: new Text('Play'),
        ),
      );
    }).toList();

    return new Column(
      children: children,
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();

      var image = await boundary?.toImage();
      ByteData byteData = await image?.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }

  _topWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[],
      ),
    );
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: _topSectionTopPadding,
              left: 20.0,
              right: 10.0,
              bottom: _topSectionBottomPadding,
            ),
            child: Container(
              height: _topSectionHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        //_buildJoin(),
                        new Text('List of players:'),
                        _playersList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 330,
              left: 20.0,
              right: 10.0,
            ),
            child: Expanded(
              child: Text("SCAN LE QRCODE POUR REJOINDRE"),
            ),
          ),
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: _dataString,
                  size: 200,
                ),
              ),
            ),
          ),
          ButtonTheme(
            minWidth: 200.0,
            child: new ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(20, 10, 20, 10)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  minimumSize: MaterialStateProperty.all(Size(250.0, 20.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.white),
                  ))),
              child: new Text(
                "LET'S GO",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                  fontSize: 40,
                ),
              ),
              onPressed: () {
                navigateToMap(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
