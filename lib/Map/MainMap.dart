import 'dart:async';
import 'dart:convert';

import 'package:annecygo/Games/TrueFalsePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:map_controller/map_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import '../WebSockets/wsCommunication.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController mapController;
  StatefulMapController statefulMapController;
  StreamSubscription<StatefulMapControllerStateChange> sub;

  bool ready = false;
  bool loaded = true;

  var markersArray = List<String>();

  void addMarker(BuildContext context) {
    statefulMapController.removeMarkers(names: markersArray).then((val) {
      markersArray = [];

      var jsonData = game.monuments;
      for (var mon in jsonData) {
        var lat = mon["geometry"]["coordinates"][1];
        var lng = mon["geometry"]["coordinates"][0];
        var name = mon["fields"]["tico"];
        var id = mon["recordid"];

        markersArray.add(id);
        statefulMapController.addMarker(
          name: id,
          marker: Marker(
              point: LatLng(lat, lng),
              builder: (BuildContext context) {
                return Container(
                  width: 400.0,
                  height: 200.0,
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: Container(
                        width: 300.0,
                        height: 80.0,
                        child: Column(children: [
                          Center(
                            child: Text(name,
                                style: TextStyle(
                                    fontFamily: "Big Noodle",
                                    fontSize: 15,
                                    backgroundColor: Colors.white60)),
                          ),
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 20,
                          )
                        ])),
                  ),
                );
              }),
        );
      }

      // ignore: unused_local_variable
      // ignore: cancel_subscriptions
      StreamSubscription<Position> positionStream =
          Geolocator.getPositionStream().listen((Position position) {
        //print(position == null ? 'lat + long ' : position.latitude.toString() + ', ' + position.longitude.toString());

        game.send('newGPSPosition', {
          'code': game.roomCode,
          'player': game.playerId,
          'position': position
        });
      });
    });
  }

  //-------Recup notre localisation avec les perms------------------------
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
  //-------------------------------

  @override
  void initState() {
    game.addListener(_onGameDataReceived);
    mapController = MapController();
    statefulMapController = StatefulMapController(mapController: mapController);
    statefulMapController.onReady.then((_) => setState(() {
          ready = true;
          addMarker(context);
        }));
    sub = statefulMapController.changeFeed.listen((change) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    sub.cancel();
    game.removeListener(_onGameDataReceived);
    super.dispose();
  }

  List<dynamic> playersList = <dynamic>[];
  List<dynamic> playersPosList = <dynamic>[];
  bool userTabLoaded = false;

  _onGameDataReceived(message) {
    switch (message["action"]) {
      case "players_list":
        playersList = message["data"];
        userTabLoaded = true;
        setState(() {});
        break;

      case "refreshPlayersPosition":
        playersPosList = message["data"];
        _refreshPlayersPos(playersPosList);
        break;

      case "newMonumentQuizz":
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrueFalsePage(
                  message["data"]["monumentId"], message["data"]["quizz"]),
            ));

        game.send("validateMonument", {
          "room": game.roomCode,
          "id": game.playerId,
          "monumentId": message["data"]["monumentId"]
        });
        break;
    }
  }

  _refreshPlayersPos(list) {
    for (var player in list) {
      //print(player["name"]);
      statefulMapController.addMarker(
        name: player["id"],
        marker: Marker(
            point: LatLng(player["position"][0], player["position"][1]),
            builder: (BuildContext context) {
              return Container(
                width: 200.0,
                height: 200.0,
                child: FittedBox(
                  fit: BoxFit.none,
                  child: Container(
                      width: 100.0,
                      height: 50.0,
                      child: Column(children: [
                        Center(
                          child: Text(player["name"],
                              style: TextStyle(fontFamily: "Big Noodle")),
                        ),
                        Container(
                            height: 25,
                            width: 25,
                            margin: EdgeInsets.only(top: 5),
                            child: new CircleAvatar(
                              backgroundImage: NetworkImage(game.avatar),
                              backgroundColor: Colors.white,
                            ),
                            decoration: new BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              shape: BoxShape.circle,
                            ))
                      ])),
                ),
              );
            }),
      );
    }
  }

  Widget _playersList() {
    List<Widget> children = playersList.map((playerInfo) {
      return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                playerInfo["name"],
                style: new TextStyle(fontSize: 25),
              )),
          Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                playerInfo["score"].toString() + " points",
                style: new TextStyle(fontSize: 25, color: Colors.red),
              ))
        ],
      );
    }).toList();

    return new Column(children: children);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: _contentWidget(),
    );
  }

  _contentWidget() {
    return Scaffold(
      body: SafeArea(
          child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          onTap: (latlang) {
            game.send('newMonumentQuizz',
                {"room": game.roomCode, "id": game.playerId});
          },
          center: LatLng(45.899247, 6.129384),
          zoom: 13.0,
        ),
        layers: [
          statefulMapController.tileLayer,
          MarkerLayerOptions(
            markers: statefulMapController.markers,
          ),
        ],
      )),
      floatingActionButton: loaded
          ? FloatingActionButton(
              child: Icon(Icons.people),
              onPressed: () {
                game.send("getPlayerList", game.roomCode);
                return showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  transitionDuration: Duration(milliseconds: 500),
                  barrierLabel: MaterialLocalizations.of(context).dialogLabel,
                  barrierColor: Colors.black.withOpacity(0.5),
                  pageBuilder: (context, _, __) {
                    return userTabLoaded
                        ? new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 3 * 2,
                                color: Colors.white,
                                child: Card(
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Center(
                                          child: Text(
                                        "Score des joueurs",
                                        style: TextStyle(fontSize: 40),
                                      )),
                                      _playersList()
                                    ],
                                  ),
                                ),
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
                                  children: <Widget>[
                                    CircularProgressIndicator()
                                  ],
                                ),
                              ),
                            ],
                          );
                  },
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOut,
                      ).drive(Tween<Offset>(
                        begin: Offset(0, -1.0),
                        end: Offset.zero,
                      )),
                      child: child,
                    );
                  },
                );
              }
              //onPressed: () => addMarker(context),
              //child: Icon(Icons.add),
              )
          : CircularProgressIndicator(),
    );
  }
}
