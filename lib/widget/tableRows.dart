// ignore_for_file: prefer_const_constructors

import 'package:calendartodo/models/taskInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TableRows extends StatefulWidget {
  final int toYear;
  final int toMonth;
  final int startNum;
  final int endNum;
  final List<int> monthData;
  final List<dynamic> taskList;
  const TableRows(
      {Key? key,
      required this.startNum,
      required this.endNum,
      required this.monthData,
      required this.taskList,
      required this.toYear,
      required this.toMonth})
      : super(key: key);

  @override
  _TableRowsState createState() => _TableRowsState();
}

class _TableRowsState extends State<TableRows> {
  @override
  void initState() {
    super.initState();
    _setRowUIList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // print(height);
    // print(width);
    return Container(
      height: 80,
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
                    child: Text(widget.monthData[i].toString().substring(6)),
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
                        // for (var item in widget.taskList)
                        //   Expanded(
                        //     flex: 7,
                        //     child: Container(
                        //       color: Colors.blue,
                        //       child:
                        //           Text("[VRIS] 모시깽이 작업${item['start_date']}"),
                        //     ),
                        //   ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            color: Colors.blue,
                            child: Text("${widget.taskList[0]['title']}"),
                          ),
                        ),

                        // Expanded(
                        //   flex: 5,
                        //   child: Container(
                        //     color: Colors.red,
                        //     child: Text("[VRIS] 모시깽이 작업"),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  void _setRowUIList() {
    List<dynamic> tasks = [];
    List<int> rowDate =
        widget.monthData.sublist(widget.startNum, widget.endNum + 1);

    for (int i = 0; i < widget.taskList.length; i++) {
      var task = widget.taskList[i];
      if (task["start_date"] < rowDate[6] && task['end_date'] > rowDate[0]) {
        tasks.add(task);
      }
    }
    print("tasks-->");
    print(tasks);
    // get List
    // print(rowDate.toString());
    print(rowDate);
    List<List<int>> taskUIList = [];
    for (var task in tasks) {
      List<int> tmp = [];
      print(task['start_date']);
      print(task['end_date']);
      if (!rowDate.contains(task['start_date'])) {
        if (!rowDate.contains(task['end_date'])) {
          tmp.add(7);
        } else {
          tmp.add(rowDate.indexOf(task['end_date']) + 1);
          tmp.add(6 - rowDate.indexOf(task['end_date']));
        }
      }
      print(tmp);
      // print(rowDate.indexOf(task['start_date']));
      // print(rowDate.indexOf(task['end_date']));
      // if(task['start_date'].toString().substring(5))
    }
  }
}
