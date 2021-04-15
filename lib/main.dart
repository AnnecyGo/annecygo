import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import "Map/MainMap.dart" as MainMap;
import 'package:socket_io_client/socket_io_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final WebSocketChannel channel =
      IOWebSocketChannel.connect('ws://86.200.111.40:1330');
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Socket socket;

  initSocket() {
    print('initSocket');

    //IO.Socket socket = IO.io('ws://86.200.111.40:1330');
  }

  @override
  void initState() {
    print('Init state');
    initSocket();
    super.initState();
  }

  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnnecyGo Home Page'),
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            onPressed: () {
              runApp(MainMap.StatefulMarkersPage());
            },
            child: Text(
              "Go to map",
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: TextField(
              controller: inputController,
              decoration: InputDecoration(
                  labelText: 'Send Message', border: OutlineInputBorder()),
              style: TextStyle(fontSize: 22),
            )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text(
                    'Send',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    if (inputController.text.isNotEmpty) {
                      //print(inputController.text);
                      widget.channel.sink.add(inputController.text);
                      inputController.text = "";
                    }
                  },
                )),
          ],
        ),
        Expanded(
            child: StreamBuilder(
                stream: widget.channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                  }
                  print('before return');
                  return Text(snapshot.data ?? 'Test');
                }))
      ]),
    );
  }
}
