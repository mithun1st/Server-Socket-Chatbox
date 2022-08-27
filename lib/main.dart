import 'package:flutter/material.dart';
import 'package:localserver_text/home_page.dart';
import 'package:localserver_text/page/Client.dart';
import 'package:localserver_text/page/server.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        ServerPage.pageName :(context) => ServerPage(),
        ClientPage.pageName :(context) => ClientPage(),
      },
    );
  }
}
