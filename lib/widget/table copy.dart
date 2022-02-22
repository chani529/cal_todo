// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calendartodo/util/getMonthFunction.dart';
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
    UtilFunction func = new UtilFunction();
    List<int> monthData = func.getMounthList();
    print(monthData);
    /*24 is for notification bar on Android*/
    return Container(
      constraints: BoxConstraints(
        maxHeight: 100,
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
              height: 400,
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
