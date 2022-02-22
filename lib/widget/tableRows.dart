// ignore_for_file: prefer_const_constructors

import 'package:calendartodo/util/getMonthFunction.dart';
import 'package:flutter/material.dart';

class TableRows extends StatefulWidget {
  final int startNum;
  final int endNum;
  const TableRows({Key? key, required this.startNum, required this.endNum})
      : super(key: key);

  @override
  _TableRowsState createState() => _TableRowsState();
}

class _TableRowsState extends State<TableRows> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // print(height);
    // print(width);
    UtilFunction func = UtilFunction();
    List<int> monthData = func.getMounthList();
    return Container(
      height: 50,
      constraints: BoxConstraints(
        minHeight: 30,
      ),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.shade400)),
      child: Stack(
        children: [
          Row(
            children: [
              for (var i = widget.startNum; i <= widget.endNum; i++)
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      child: Text(monthData[i].toString()),
                    ),
                  ),
                ),
            ],
          ),
          Positioned(
              top: 0,
              left: 0,
              width: width,
              height: 50,
              child: Column(
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                        // color: Colors.black,
                        border: Border.all(width: 1, color: Colors.blue)),
                  ),
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                        // color: Colors.black,
                        border: Border.all(width: 1, color: Colors.blue)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.blue,
                            child: Text("[VRIS] 모시깽이 작업"),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: Colors.red,
                            child: Text("[VRIS] 모시깽이 작업"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
