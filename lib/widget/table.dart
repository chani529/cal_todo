// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CalTable extends StatefulWidget {
  const CalTable({Key? key}) : super(key: key);

  @override
  _CalTableState createState() => _CalTableState();
}

class _CalTableState extends State<CalTable> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    print(height);
    print(width);
    var now = DateTime.now();
    int nowMonth = 2;
    var selectedDate = DateTime(2022, nowMonth, 1);
    var selectedDateFirstWeekSunday = DateTime(now.year, nowMonth,
        1 - (selectedDate.weekday != 7 ? selectedDate.weekday : 0));
    // var test = now.add(0 - now.weekday).day;

    var prevMonthDate = DateTime(now.year, nowMonth, 0);
    var selectedEndDate = DateTime(now.year, nowMonth + 1, 0);
    List MonthData = [];
    if (selectedDateFirstWeekSunday.day != 1) {
      for (int i = selectedDateFirstWeekSunday.day;
          i <= prevMonthDate.day;
          i++) {
        MonthData.add(i);
      }
    }
    for (int i = 1; i <= selectedEndDate.day; i++) {
      MonthData.add(i);
    }
    for (int i = 1; MonthData.length < 42; i++) {
      MonthData.add(i);
    }
    /*24 is for notification bar on Android*/
    return Container(
      constraints: BoxConstraints(
        maxHeight: height,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: Colors.grey.shade400)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: Colors.grey.shade400)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: Colors.grey.shade400)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: Colors.grey.shade400)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: Colors.grey.shade400)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: Colors.grey.shade400)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: Colors.grey.shade400)),
                ),
              ),
            ],
          ),
          Positioned(
              top: 0,
              left: 0,
              width: width,
              height: 800,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(width: 3, color: Colors.red)),
                child: Column(
                  children: [
                    Container(
                      // height: 600,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(width: 3, color: Colors.blue)),
                    )
                  ],
                ),
                // color: Colors.,
              )),
        ],
      ),
    );
  }
}
