import 'package:easyfahr/modules/userModule.dart';
import 'package:easyfahr/modules/weekModule.dart';
import 'package:easyfahr/sites/Loginscreen.dart';
import 'package:easyfahr/tabs/Einstellungen.dart';
import 'package:easyfahr/tabs/Statistik.dart';
import 'package:easyfahr/tabs/Uebersicht.dart';
import 'package:flutter/material.dart';
import 'package:isoweek/isoweek.dart';

class Homepage extends StatefulWidget {
  late List<UserModule> userListe;

  Homepage(this.userListe);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
    int _selectIndex = 0;

    //String anzeigeFahrer =  'admin';//Der der mit Fahren dran ist !!Name muss auch in userListe enthalten sein, sonst error

    List<WeekModule> weekList = [
      WeekModule(1,'admin'),
      WeekModule(2,'test')
    ]..sort((a,b)=>a.weekNumber.compareTo(b.weekNumber));

    String changeAnzeigeFahrer(){ //Problem: Wenn unter Einstellungen ein Fahrer angepasst oder KW erstellt wird, wird es hier nicht geupdatet
      int weekNow = Week.fromDate(DateTime.now()).weekNumber;
      String anzeigeFahrer = '';
      try{

        anzeigeFahrer = weekList[weekNow].driverName;
      } catch (Exception){
        anzeigeFahrer = '';
      }
      return anzeigeFahrer;
    }

    //Folgende Listen müssen auf der Homepage sein und nicht in Uebersicht, da sonst Wert zurückgesetzt bei Tab wechsel
    List<bool> _check = [false,false,false,false,false];      //für checked auf Uebersicht für jeden Wochentag, deswegen List mit 5
    List<bool> _notDriven = [false,false,false,false,false,]; //dasselbe nur unchecked

    List<String> wochentage = [
      'Montag',
      'Dienstag',
      'Mittwoch',
      'Donnerstag',
      'Freitag'
    ];


    Map<String, Object> fahrerEinteilung = {
      'Montag': '',
      'Dienstag': '',
      'Mittwoch': '',
      'Donnerstag': '',
      'Freitag': ''
    };

    

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectIndex,
          onTap: (index) => setState(() => _selectIndex = index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),label: 'Übersicht'),
            BottomNavigationBarItem(
                icon: Icon(Icons.score), label: 'Statistik'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Einstellungen'),
          ],
        ),
        body: Container(
          //height: MediaQuery.of(context).size.height*0.7,
          child: Column(children: [
            if(_selectIndex==0)
              Uebersicht(
                  anzeigeFahrer: changeAnzeigeFahrer(),
                  wochentage: wochentage,
                  check: _check,
                  notDriven: _notDriven,
                  fahrerEinteilung: fahrerEinteilung,
                  userListe: widget.userListe),
            if(_selectIndex==1)
              Statistik(fahrerEinteilung,widget.userListe),
            if(_selectIndex==2)
              Einstellungen(widget.userListe,weekList)
          ],),
        )
      );
    }
  }

