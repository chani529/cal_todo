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
    _setRowUIList();
    // print(height);
    // print(width);
    return FutureBuilder(
        future: _setRowUIList(),
        builder: (contexta, AsyncSnapshot snapshota) {
          return Container(
            height: 85.0 +
                (snapshota.data != null && snapshota.data.length > 3
                    ? (snapshota.data.length - 3) * 20.0
                    : 0.0),
            // height: 80.0 * widget.taskList.length,
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
                          child:
                              Text(widget.monthData[i].toString().substring(6)),
                        ),
                      ),
                  ],
                ),
                FutureBuilder(
                    future: _setRowUIList(),
                    builder: (context1, AsyncSnapshot snapshot1) {
                      return Positioned(
                          top: 0,
                          left: 0,
                          width: width,
                          height: 85.0 +
                              (snapshot1.data != null &&
                                      snapshot1.data.length > 3
                                  ? (snapshot1.data.length - 3) * 20.0
                                  : 0.0),
                          child: FutureBuilder(
                            future: _setRowUIList(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                          // color: Colors.black,
                                          border: Border.all(
                                              width: 1, color: Colors.blue)),
                                    ),
                                    for (var item in snapshot.data)
                                      Container(
                                        height: 20,
                                        decoration: BoxDecoration(
                                            // color: Colors.black,
                                            border: Border.all(
                                                width: 1, color: Colors.black)),
                                        child: Row(
                                          children: [
                                            for (var task in item)
                                              // print(task);
                                              Expanded(
                                                flex: task,
                                                child: Container(
                                                  // color: Colors.blue,
                                                  decoration: BoxDecoration(
                                                      // color: Colors.black,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.black)),
                                                  child: Text(
                                                      "${task.toString()}"),
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
                                );
                              } else {
                                return Text("xxx");
                              }
                            },
                          ));
                    }),
              ],
            ),
          );
        });
  }

  Future<List<List<int>>> _setRowUIList() async {
    List<dynamic> tasks = [];
    List<int> rowDate =
        widget.monthData.sublist(widget.startNum, widget.endNum + 1);

    for (int i = 0; i < widget.taskList.length; i++) {
      var task = widget.taskList[i];
      if (task["start_date"] <= rowDate[6] && task['end_date'] >= rowDate[0]) {
        tasks.add(task);
      }
    }
    List<List<int>> taskUIList = [];
    print(rowDate);
    for (int j = 0; j < tasks.length; j++) {
      var task = tasks[j];
      List<int> tmp = [];
      // print(task['start_date']);
      // print(task['end_date']);

      //로직 검토
      // start date가 이번주가 아닌경우 (이 전에 시작된 일정)
      print(task);
      if (!rowDate.contains(task['start_date'])) {
        // 이번 주 종료 일정이 아닌 경우
        if (!rowDate.contains(task['end_date'])) {
          // 7칸 전부 색칠
          tmp.add(7);
        } else {
          // 이번주 종료 이벤트 인덱스가 0부터 시작이기 때문에 +1
          tmp.add(rowDate.indexOf(task['end_date']) + 1);
          // 종료 일 이후 빈칸 만들기 (7일 꽉 차있으면 안만들기 위함)
          if ((rowDate.indexOf(task['end_date']) + 1) != 7) {
            tmp.add(6 - rowDate.indexOf(task['end_date']));
          }
        }
      } else {
        // 시작 인덱스가 0이면 1로 주기
        if (rowDate.indexOf(task['start_date']) == 0) {
          if (rowDate.indexOf(task['end_date']) == 0) {
            tmp.add(1);
          } else {
            if (!rowDate.contains(task['end_date'])) {
              tmp.add(7);
            } else {
              tmp.add(rowDate.indexOf(task['end_date']) + 1);
            }
          }
        } else {
          tmp.add(rowDate.indexOf(task['start_date']));
          if (!rowDate.contains(task['end_date'])) {
            tmp.add(7 - rowDate.indexOf(task['start_date']));
          } else if (rowDate.indexOf(task['end_date']) -
                  rowDate.indexOf(task['start_date']) ==
              0) {
            tmp.add(1);
          } else {
            tmp.add(rowDate.indexOf(task['end_date']) -
                rowDate.indexOf(task['start_date']));
          }
        }
        // end_date가 포함되지 않았을 경우 (종료 일이 이번 주가 아닌 경우)
        // if (!rowDate.contains(task['end_date'])) {
        int endRow = 0;
        for (int i = 0; i < tmp.length; i++) {
          int element = tmp[i];
          endRow += element;
        }
        if (endRow != 7) {
          tmp.add(7 - endRow);
        }
      }
      taskUIList.add(tmp);
    }
    print(taskUIList);
    return taskUIList;
  }
}
