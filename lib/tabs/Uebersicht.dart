import 'package:easyfahr/modules/userModule.dart';
import 'package:flutter/material.dart';

class Uebersicht extends StatefulWidget {
  late String anzeigeFahrer;
  late List<String> wochentage;
  late List<bool> check;
  late List<bool> notDriven;
  late Map<String, Object> fahrerEinteilung;
  late List<UserModule> userListe;
  Uebersicht({
    required this.anzeigeFahrer,
    required this.wochentage,
    required this.check,
    required this.notDriven,
    required this.fahrerEinteilung,
    required this.userListe});

  @override
  _UebersichtState createState() => _UebersichtState();
}

class _UebersichtState extends State<Uebersicht> {



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Card(
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const FittedBox(
                    child:
                    Text('Fahrer', style: TextStyle(fontSize: 30))),
                Text(
                  widget.anzeigeFahrer,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                )
              ],
            ),
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Card(
              elevation: 5,
              child: ListView.builder(
                itemCount: widget.wochentage.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return LayoutBuilder(builder: (context, constraints) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: constraints.maxWidth * 0.3,
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(widget.wochentage[index]))),
                          Container(
                              width: constraints.maxWidth * 0.2,
                              child: IconButton(
                                  onPressed: () {
                                    setState((){
                                            widget.notDriven[index] = false;
                                            widget.check[index] = true;
                                            widget.fahrerEinteilung[
                                            widget.wochentage[index]] = widget.anzeigeFahrer;

                                    });
                                  },
                                  icon: Icon(
                                    Icons.done,
                                    color: widget.check[index]
                                        ? Colors.green
                                        : Colors.grey,
                                  ))),
                          Container(
                              width: constraints.maxWidth * 0.2,
                              child: IconButton(
                                  onPressed: () {
                                    setState((){
                                      widget.notDriven[index] = true;
                                      widget.check[index] = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: widget.notDriven[index]
                                        ? Colors.red
                                        : Colors.grey,
                                  ))),
                          Container(
                            width: constraints.maxWidth * 0.3,
                            child: DropdownButton<String>(
                              value: widget.check[index]
                                  ? widget.anzeigeFahrer
                                  : widget.fahrerEinteilung[widget.wochentage[index]]
                                  .toString(),
                              onChanged: widget.notDriven[index]
                                  ?  (value) {
                                //nur aktiv wenn X angeklickt
                                setState(() {
                                  widget.fahrerEinteilung[
                                  widget.wochentage[index]] = value!;
                                });
                              } : null,
                              items: widget.userListe
                                  .map<DropdownMenuItem<String>>(
                                      (e) => DropdownMenuItem(
                                    child: Text(e.newusername),
                                    value: e.newusername,
                                  ))
                                  .toList(),
                            ),
                          )
                        ]);
                  });
                },
              ),
            ))
      ],
    );
  }
}
