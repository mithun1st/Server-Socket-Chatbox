import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localserver_text/server/network.dart';

class ServerController extends GetxController {
  Server? server;
  List<String> serverLogs = [];

  TextEditingController messageController = TextEditingController();

  Future<void> startOrStopServer() async {
    if (server!.runing) {
      await server!.close();
      serverLogs.clear();
      print('server close-');
    } else {
      await server!.start();
      print('server running-');
    }
    update();
  }

  Future<void> startServer() async {
    await server!.start();
    print('------------------got it');
  }

  @override
  void onInit() {
    server = Server(onData);
    startServer();
    super.onInit();
  }

  void onData(Uint8List data) {
    startServer();
    final reciveData = String.fromCharCodes(data);
    serverLogs.insert(0, reciveData);
    update();
    
  }


  void handelMsg() {
    server!.broadcast(messageController.text);
    messageController.clear();
    update();
    
  }

}
