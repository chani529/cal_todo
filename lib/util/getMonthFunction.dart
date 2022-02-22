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
        monthData.add(i);
      }
    }
    for (int i = 1; i <= selectedEndDate.day; i++) {
      monthData.add(i);
    }
    for (int i = 1; monthData.length < 42; i++) {
      monthData.add(i);
    }
    return monthData;
  }
}
