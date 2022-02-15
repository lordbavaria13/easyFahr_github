import 'package:flutter/material.dart';
import 'sites/Loginscreen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easyfahr',
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('easyFahr'),),
        body: Login(),
      ),
    );
  }
}



