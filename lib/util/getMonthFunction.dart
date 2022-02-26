// ignore_for_file: file_names, camel_case_types

class UtilFunction {
  List<int> getMounthList(int year, int month) {
    var now = DateTime.now();
    var selectedDate = DateTime(year, month, 1);
    var selectedDateFirstWeekSunday = DateTime(year, month,
        1 - (selectedDate.weekday != 7 ? selectedDate.weekday : 0));
    // var test = now.add(0 - now.weekday).day;

    var prevMonthDate = DateTime(year, month, 0);
    var selectedEndDate = DateTime(year, month + 1, 0);
    List<int> monthData = [];
    if (selectedDateFirstWeekSunday.day != 1) {
      for (int i = selectedDateFirstWeekSunday.day;
          i <= prevMonthDate.day;
          i++) {
        var tmp = '';
        if (month == 1) {
          tmp = "${year - 1}12";
        } else if (month - 1 < 10) {
          tmp = "${year}0${month - 1}";
        } else {
          tmp = '$year${month - 1}';
        }
        monthData.add(int.parse("$tmp$i"));
      }
    }
    for (int i = 1; i <= selectedEndDate.day; i++) {
      var tmp = '';
      if (month < 10) {
        tmp = "${year}0$month";
      } else {
        tmp = '$year$month';
      }
      if (i < 10) {
        tmp += "0$i";
      } else {
        tmp += i.toString();
      }
      monthData.add(int.parse(tmp));
    }
    for (int i = 1; monthData.length < 42; i++) {
      var tmp = '';
      if (month == 12) {
        tmp = "${year + 1}01";
      } else if (month + 1 < 10) {
        tmp = "${year}0${month + 1}";
      } else {
        tmp = '$year${month + 1}';
      }
      if (i < 10) {
        tmp += "0$i";
      } else {
        tmp += i.toString();
      }
      monthData.add(int.parse(tmp));
    }
    return monthData;
  }
}
