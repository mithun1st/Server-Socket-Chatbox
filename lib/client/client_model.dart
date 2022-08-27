import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';

typedef Unit8ListCallback = Function(Uint8List data);
typedef dynamicCallback = Function(dynamic data);

class ClaintModel {
  String hostname;
  int port;
  Unit8ListCallback onData;

  ClaintModel(
      {required this.hostname,
      required this.onData,
      required this.port});

  bool isconected = false;
  Socket? socket;
  Future<void> conectet() async {
    try {
      socket = await Socket.connect(hostname, port);
      socket!.listen(onData, onDone: () async {
        disconect();
        isconected = false;
      });
      isconected = true;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void write(String message) {
    socket!.write(message);
  }

  void disconect() {
    final message = "AND Disconnect";
    write(message);
    if (socket != null) {
      socket!.destroy();
    }
  }
}
