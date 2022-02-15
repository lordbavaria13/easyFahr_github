import 'package:easyfahr/modules/userModule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Statistik extends StatefulWidget {
  late Map<String,Object> fahrerEinteilung;
  late List<UserModule> userListe;
  Statistik(this.fahrerEinteilung,this.userListe);

  @override
  _StatistikState createState() => _StatistikState();
}

class _StatistikState extends State<Statistik> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height*0.7,
        width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Text('Fahrten Gesamt', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            Container(
              height: 300,
              child: ListView.builder(
                  itemCount: widget.userListe.length,
                  itemBuilder: (context, index){
                    return Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height*0.07,
                          width: MediaQuery.of(context).size.width*0.9,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(220, 220, 220, 1),),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.5,
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    color: Colors.teal[200]),
                                ),
                              ),
                              Text(widget.userListe[index].newusername),
                            ],
                          ),
                        ),
                        Text('10',style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
