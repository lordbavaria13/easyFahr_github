import 'package:flutter/material.dart';

class Anmeldung extends StatelessWidget {
  late Function addItem;
  Anmeldung(this.addItem);
   final TextEditingController _name = TextEditingController();
   final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(leading: Text('Benutzername'),title: Container(width:100,child: TextField(controller: _name,)),),
                ListTile(leading: Text('Passwort'),title: Container(width:100,child: TextField(controller: _password,)),),
                ElevatedButton(onPressed: ()=>addItem(_name.text,_password.text), child: Text('Registrieren'))
              ]),),
    );
  }
}
