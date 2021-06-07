import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'wsNotifs.dart';

///
/// Again, application-level global variable
///
GameCommunication game = new GameCommunication();

class GameCommunication {
  static final GameCommunication _game = new GameCommunication._internal();

  String _playerName = "";
  String _playerID = "";
  String _roomCode = "";
  String _avatar = "";
  bool _isAdmin = false;
  Iterable _monuments = null;

  factory GameCommunication() {
    return _game;
  }

  GameCommunication._internal() {
    sockets.initCommunication();
    sockets.addListener(_onMessageReceived);
  }

  String get playerName => _playerName;
  String get roomCode => _roomCode;
  String get avatar => _avatar;
  bool get isAdmin => _isAdmin;
  Iterable get monuments => _monuments;

  setPlayerName(name) {
    _playerName = name;
  }

  setMonuments(data) {
    _monuments = data;
  }

  _onMessageReceived(serverMessage) {
    Map message = json.decode(serverMessage);

    switch (message["action"]) {

      ///
      /// When the communication is established, the server
      /// returns the unique identifier of the player.
      /// Let's record it
      ///
      case 'connect':
        _playerID = message["data"];
        break;

      case 'savePlayer':
        print("SAVE PLAYER");
        _avatar = message["data"]["avatar"];
        _isAdmin = message["data"]["admin"];
        print(isAdmin);
        print(message["data"]);
        break;

      case 'joinRoom':
        _roomCode = message["code"];
        break;

      ///
      /// For any other incoming message, we need to
      /// dispatch it to all the listeners
      ///
      default:
        _listeners.forEach((Function callback) {
          callback(message);
        });
        break;
    }
  }

  send(String action, data) {
    sockets.send(json.encode({"action": action, "data": data}));
  }

  ObserverList<Function> _listeners = new ObserverList<Function>();

  addListener(Function callback) {
    _listeners.add(callback);
  }

  removeListener(Function callback) {
    _listeners.remove(callback);
  }
}
