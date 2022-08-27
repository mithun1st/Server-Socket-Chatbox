import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localserver_text/client/client_controller.dart';
import 'package:localserver_text/server/server_controller.dart';

class ClientPage extends StatefulWidget {
  static final String pageName = 'clientPage';

  @override
  State<StatefulWidget> createState() {
    return ClientPageState();
  }
}

class ClientPageState extends State<ClientPage> {
  static TextEditingController tfSendCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: TextField(
                controller: ClientController.addressIp,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter The Server IP'),
              )),
              ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('Connect'))
            ],
          ),
          //after connect
          if (!ClientController.addressIp!.text.isEmpty)
            GetBuilder<ClientController>(
                init: ClientController(),
                builder: (controller) {
                  if (controller.claintModel != null) {
                    return Column(
                      children: [
                        Text('Server IP: ${ClientController.addressIp!.text}'),
                        Container(
                          color: Colors.grey,
                          height: 200,
                          child: ListView.builder(
                            reverse: true,
                            itemCount: controller.logs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                alignment: Alignment.topLeft,
                                child:
                                    Chip(label: Text(controller.logs[index])),
                              );
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: tfSendCtrl,
                                decoration:
                                    InputDecoration(labelText: 'Type Text'),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await controller.claintModel!.conectet();
                                setState(() {
                                  controller.sendMessage(tfSendCtrl.text);
                                });
                                tfSendCtrl.clear();
                              },
                              icon: Icon(Icons.send),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  //------------
                  else {
                    return Text('Error');
                  }
                }),
        ],
      ),
    );
  }
}
