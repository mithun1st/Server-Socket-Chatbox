import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

typedef Unit8ListCallback = Function(Uint8List ondata);

class Server {
  Unit8ListCallback? ondata;
  Server(this.ondata,);

  static TextEditingController ipTextCtrl=TextEditingController(text: '192.168.');

  ServerSocket? server;
  bool runing=false;
  List<Socket> sokets = [];

  Future<void> start() async {
    
    runZoned(() async {
      server = await ServerSocket.bind(ipTextCtrl.text, 4000);
      runing = true;
      server!.listen(OnRequest);
      const massage = 'Server is lisening port 4000';
      ondata!(Uint8List.fromList(massage.codeUnits));
    }
     
    );
  }

 void OnRequest(Socket socket) {
    if (!sokets.contains(socket)) {
      sokets.add(socket);
    }
    socket.listen((event) {
      
      ondata!(event);
    });
  }

  Future <void> close()async{
    await server!.close();
    server=null;
    runing=false;
  }

  void broadcast(String data){    
    ondata!(Uint8List.fromList('Broadcast: $data'.codeUnits));
    
    for(final s in sokets){
      s.write(data);
    }
  }


}
