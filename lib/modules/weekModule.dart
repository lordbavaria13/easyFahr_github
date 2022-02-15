import 'package:isoweek/isoweek.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class WeekModule{
  late int weekNumber;
  late String driverName;

  get weekDuration{
    Week currentWeek = Week.fromISOString('2022W$weekNumber');
    initializeDateFormatting('de_DE', null);
    String firstDay = DateFormat.yMd('de_DE').format(currentWeek.days.first);
    String lastDay = DateFormat.yMd('de_DE').format(currentWeek.days.last);
    return '$firstDay - $lastDay';
  }

  get driverNameForWeekNow{
    return Week.fromDate(DateTime.now()).weekNumber;
  }
  WeekModule(this.weekNumber,this.driverName);

}