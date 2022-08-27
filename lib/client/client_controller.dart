import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:localserver_text/client/client_model.dart';
//import 'package:ping_discover_network/ping_discover_network.dart';

class ClientController extends GetxController {
  ClaintModel? claintModel;
  List<String> logs = [];
  int port = 4000;

  //NetworkAddress? address;
  // Stream<NetworkAddress>? stream;

  static TextEditingController? addressIp = TextEditingController();
  @override
  void onInit() {
    // getApiAdderss();
    getApiAdderss1();
    super.onInit();
  }

  getApiAdderss1() {
    claintModel = ClaintModel(
      hostname: addressIp!.text,
      onData: onData,
      port: port,
    );
    update();
  }

  // getApiAdderss() async {
  //   stream = await NetworkAnalyzer.discover2('192.168.1', port);
  //   stream!.listen((NetworkAddress networkAddress) {
  //     if (networkAddress.exists) {
  //       address = networkAddress;
  //       claintModel = ClaintModel(
  //           hostname: networkAddress.ip,
  //           onData: onData,
  //           onError: onError,
  //           port: port);
  //     }
  //   });
  //   update();
  // }

  void sendMessage(String message) {
    
    claintModel!.write(message);
    
  }

  onData(Uint8List data) {
    final message = String.fromCharCodes(data);
    logs.insert(0,message);
    update();
  }

  @override
  void dispose() {
    claintModel = null;
    super.dispose();
  }
}
