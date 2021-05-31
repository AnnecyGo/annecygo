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
    Map<String, String> headers = {"Keep-Alive": "timeout=20, max=1000"};
    Future<http.Response> fetchMonuments() {
      return http.get(Uri.http('86.200.111.40:1332', 'annecyRandomMonuments'),
          headers: headers);
    }

    setState(() {
      loaded = false;
    });

    try {
      fetchMonuments().then((response) {
        statefulMapController.removeMarkers(names: markersArray).then((val) {
          markersArray = [];

          String jsonStr = response.body.toString();
          var jsonData = jsonDecode(jsonStr);

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
                    return const Icon(Icons.location_on);
                  }),
            );
          }

          StreamSubscription<Position> positionStream = Geolocator.getPositionStream().listen(
                  (Position position)  { // ignore: cancel_subscriptions
                //print(position == null ? 'lat + long ' : position.latitude.toString() + ', ' + position.longitude.toString());
                statefulMapController.addMarker(
                  name: "player",
                  marker: Marker(
                      point: LatLng(position.latitude, position.longitude),
                      builder: (BuildContext context) {
                        return const Icon(Icons.directions_walk);
                      }),
                );
              });


          setState(() {
            loaded = true;
          });
        });

      });
    } on Exception catch (exception) {
      print(exception);
    } catch (error) {
      print(error);
    }
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
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
          child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          onTap: (latlang) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TrueFalsePage()),
            );
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
          onPressed: () {
            showDialog(
              context: context,builder: (_) => NetworkGiffyDialog(
              image: Image.network("https://i.ibb.co/QkL7H4R/participants.png",
              ), title: Text('List des participants ......',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600)),
              description:Text('',
                textAlign: TextAlign.center,
              ),
              entryAnimation: EntryAnimation.LEFT,
              onlyCancelButton: true,
            ) );
          }
              //onPressed: () => addMarker(context),
              //child: Icon(Icons.add),
            )
          : CircularProgressIndicator(),

    ));
  }





  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}
