import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localserver_text/server/network.dart';
import 'package:localserver_text/server/server_controller.dart';

class ServerPage extends StatefulWidget {
  static final String pageName = 'serverPage';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ServerPageState();
  }
}

class ServerPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Server'),
      ),
      body: Center(
        child: GetBuilder<ServerController>(
          init: ServerController(),
          builder: (controller) {
            String connection;
            if (controller.server!.runing) {
              connection = ' Server Status: ON';
            } else {
              connection = 'Server Status: OFF';
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(connection),
                    Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: Server.ipTextCtrl,
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: 'Server Address'),
                          enabled: !controller.server!.runing,
                        )),
                        ElevatedButton(
                          child: Text(controller.server!.runing
                              ? 'Server Off'
                              : 'Server On'),
                          onPressed: () async {
                            await controller.startOrStopServer();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                if (controller.server!.runing)
                  Expanded(
                    child: Container(
                      color: Colors.blue.shade200,
                      child: ListView.builder(
                        reverse: true,
                        itemCount: controller.serverLogs.length,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.topLeft,
                            child:
                                Chip(label: Text(controller.serverLogs[index])),
                          );
                        },
                      ),
                    ),
                  ),

                //---------------text send
                if (controller.server!.runing)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.messageController,
                        ),
                      ),
                      ElevatedButton(
                        child: Text('Sent'),
                        onPressed: () {
                          controller.handelMsg();
                        },
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
