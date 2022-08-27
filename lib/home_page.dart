
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localserver_text/page/Client.dart';
import 'package:localserver_text/page/server.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Host'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ServerPage.pageName);
              },
              child: Text('Server'),
            ),
            ///
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ClientPage.pageName);
              },
              child: Text('Client'),
            ),
          ],
        ),
      ),
    );
  }
}
