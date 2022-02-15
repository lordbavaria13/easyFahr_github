import 'package:easyfahr/modules/userModule.dart';
import 'package:flutter/material.dart';

import 'Homepage.dart';
import 'anmeldung.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _pwdCtrl = TextEditingController();
  late String username;
  late String password;

  List<UserModule> userList = [
    UserModule('test', '111'),
    UserModule('admin', 'passw0rd'),
    UserModule('', 'kompliziert')
  ];

  void addNewUser(newusername,newpassword){
    userList.add(UserModule(newusername, newpassword));
  }

  void checkUser() {
    username = _nameCtrl.text;
    password = _pwdCtrl.text;

    for (var x in userList) {
      if (username == x.newusername && password == x.newpassword) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Homepage(userList)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child:
    Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(controller: _nameCtrl,
            decoration: InputDecoration(labelText: 'username'),),
          TextFormField(controller: _pwdCtrl,obscureText: true,
            decoration: InputDecoration(labelText: 'password',),),
          Container(width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(10),
              child: ElevatedButton(onPressed: checkUser, child: Text('Log In'))),
          Container(width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Anmeldung(addNewUser))),
                child: Text('Anmelden'),))
        ],
      ),
    )
    );
  }
}