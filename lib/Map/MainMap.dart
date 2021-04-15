import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:map_controller/map_controller.dart';

class _StatefulMarkersPageState extends State<StatefulMarkersPage> {
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
                    }));
          }

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
              onPressed: () => addMarker(context),
              child: Icon(Icons.refresh),
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

class StatefulMarkersPage extends StatefulWidget {
  @override
  _StatefulMarkersPageState createState() => _StatefulMarkersPageState();
}
