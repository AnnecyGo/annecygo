import 'package:annecygo/PagesExplication/PageLetsGo.dart';
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
  GlobalKey globalKey = new GlobalKey();
  String _dataString = "";

  List<dynamic> playersList = <dynamic>[];

  Future navigateToMap(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GoPage()));
  }

  @override
  void initState() {
    super.initState();
    game.addListener(_onGameDataReceived);
    game.send('getPlayerList', null);
    if (game.roomCode != "") {
      game.send('getPlayerList', game.roomCode);
      game.send('getRoom', game.roomCode);
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
        print("PLAYER LIST");
        print(playersList);
        setState(() {});
        break;

      case "startGame":
        navigateToMap(context);
        break;

      case "saveRoom":
        var data = message["data"];
        game.setMonuments(data);
        break;
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
          title:
              /*Text(
            "Room: " + game.roomCode,
            style: TextStyle(
              color: Colors.black54,
            ),
          )*/
              Text(
            "Mon groupe",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900),
          ),
          backgroundColor: Color(0xFFF12D37),
        ),
        body: _contentWidget(),
      ),
    );
  }

  Widget _playersList() {
    List<Widget> children = playersList.map((playerInfo) {
      return new Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(game.avatar),
            ),
          ),
          Text(
            playerInfo["name"],
            style: new TextStyle(fontSize: 25),
          )
        ],
      ));
    }).toList();

    return new Container(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        children: children,
        childAspectRatio: 32 / 9,
      ),
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
    return Container(
      child: !playersList.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: _playersList(),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Color(0xFF9A9A9A),
                          height: 36,
                        )),
                    new Text(
                      'Scan le QR Code pour rejoindre',
                      style: new TextStyle(
                          fontSize: 20,
                          color: Color(0xFF949494),
                          fontWeight: FontWeight.w900),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RepaintBoundary(
                          key: globalKey,
                          child: QrImage(
                            data: _dataString,
                            size: 170,
                          ),
                        )
                      ],
                    ),
                    ButtonTheme(
                      minWidth: 200.0,
                      child: game.isAdmin
                          ? new Container(
                              padding: EdgeInsets.only(
                                  bottom: 10, top: 10, right: 10, left: 10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.fromLTRB(20, 10, 20, 10)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(250.0, 20.0)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
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
                                  game.send('startGame', game.roomCode);
                                },
                              ))
                          : Text("En attende du chef de partie..."),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[CircularProgressIndicator()],
                  ),
                ),
              ],
            ),
    );
  }
}
