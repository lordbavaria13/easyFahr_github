import 'package:easyfahr/modules/userModule.dart';
import 'package:easyfahr/modules/weekModule.dart';
import 'package:flutter/material.dart';
import 'package:isoweek/isoweek.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class Einstellungen extends StatefulWidget {
  late List<UserModule> userListe;
  late List<WeekModule> weekList;
  Einstellungen(this.userListe,this.weekList);
  


  @override
  _EinstellungenState createState() => _EinstellungenState();
}

class _EinstellungenState extends State<Einstellungen> {
  DateTime _selectedDate = DateTime.now();

  Future addWeekDialog(){
    return showDialog(context: context, builder: (BuildContext context){
      return Dialog(child:
        StatefulBuilder(
          builder: (BuildContext context, StateSetter pickerState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WeeklyDatePicker(
                  selectedDay: _selectedDate,
                  changeDay: (value) => pickerState((){_selectedDate = value;}),
                  weekdayText: 'Woche',
                ),
                Row(children: [
                  Text('Zeitraum: '),
                  Text(WeekModule(Week.fromDate(_selectedDate).weekNumber,'').weekDuration),
                  ]
                ),
                ElevatedButton(onPressed: ()=>setState(() {
                  widget.weekList.add(
                      WeekModule(Week.fromDate(_selectedDate).weekNumber, ''));
                }), child: Text('Hinzufügen'))
              ],
            );
          }));
    });
  }



  // Alert Dialog um die Fahrer für jede Kalenderwoche einzustellen
  Future changeDriver(index){
      return showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          content: Row(
            children: [
              Text('neuer Fahrer: ',style: TextStyle(fontWeight: FontWeight.bold),),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter dropDownState){
                return DropdownButton<String>(
                  value: widget.weekList[index].driverName,
                  onChanged: (value) {
                    dropDownState(() { //State für den Wert im Dropdown Menü
                      widget.weekList[index].driverName = value!;
                    });
                    setState(() { //State für den Wert in der App
                      widget.weekList[index].driverName = value!;
                    });

                  },
                  items: widget.userListe
                      .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem(
                        child: Text(e.newusername),
                        value: e.newusername,
                      ))
                      .toList(),
                );},
              ),
            ],
          ));
      });
  }

  @override
  Widget build(BuildContext context) {
    //widget.weekList.sort((a,b)=>a.weekNumber.compareTo(b.weekNumber));  //Wochenliste wird zuvor noch sortiert
    return Center(
      child: Column(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width*0.9,
            child: Card(elevation: 5, 
              child: ListTile(
                leading: Text('KW',style: TextStyle(fontWeight: FontWeight.bold),),
                title: Text('Fahrer',style: TextStyle(fontWeight: FontWeight.bold),),
                trailing: IconButton(onPressed: ()=>addWeekDialog(), icon: Icon(Icons.add_circle,color: Colors.teal,)),
              ),),
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height*0.6,
            child: ListView.builder(
                itemCount: widget.weekList.length,
                itemBuilder: (context,index){
                  return Column(
                    children: [
                      ListTile(
                        leading: Text(widget.weekList[index].weekNumber.toString()),
                        title: Text(widget.weekList[index].driverName),
                        subtitle: Text(widget.weekList[index].weekDuration),
                        trailing: IconButton(icon: Icon(Icons.change_circle, color: Colors.teal[200]),
                          onPressed: ()=>setState(() {
                            changeDriver(index);
                          })
                      )),
                      const Divider(thickness: 2,)
                    ],
                  );
            }),
          ),
        ],
      ),
    );
  }
}
