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
                    child: Text(widget.monthData[i].toString()),
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
    List<dynamic> tmp = [];
    var rowEndDate = '';
    rowEndDate = (widget.toMonth == 12 &&
                widget.endNum >= 20 &&
                widget.monthData[widget.endNum] < 10
            ? widget.toYear + 1
            : widget.toYear)
        .toString();
    var tmpMonth;
    if (widget.endNum >= 20 && widget.monthData[widget.endNum] < 14) {
      tmpMonth = widget.toMonth + 1 > 12 ? 1 : widget.toMonth + 1;
    } else {
      tmpMonth = widget.toMonth;
    }
    rowEndDate += tmpMonth < 10 ? "0$tmpMonth".toString() : tmpMonth.toString();
    rowEndDate += widget.monthData[widget.endNum] < 10
        ? "0${widget.monthData[widget.endNum]}"
        : widget.monthData[widget.endNum].toString();
    print("rowEndDate==>");
    print(rowEndDate);
    int startDate = 0;
    if (widget.startNum == 0) {
      print("${widget.startNum}x0");
      startDate = int.parse(
          "${widget.monthData[0] != 1 && widget.toMonth == 1 ? widget.toYear - 1 : widget.toYear}${widget.monthData[0] != 1 ? widget.toMonth != 1 && widget.toMonth - 1 < 10 ? 0 : "" : widget.toMonth < 10 ? 0 : ""}${widget.monthData[0] != 1 ? widget.toMonth == 1 ? 12 : widget.toMonth - 1 : widget.toMonth}${widget.monthData[0] == 1 ? 01 : widget.monthData[0]}");
    } else if (widget.startNum > 20) {
      print("${widget.startNum}x1");
      startDate = int.parse(
          "${widget.monthData[widget.startNum] < 10 && widget.toMonth == 12 ? widget.toYear + 1 : widget.toYear}${widget.monthData[widget.startNum] < 10 ? widget.toMonth != 12 && widget.toMonth + 1 < 10 ? 0 : "" : widget.toMonth < 10 ? 0 : ""}${widget.monthData[widget.startNum] < 10 ? widget.toMonth == 12 ? 1 : widget.toMonth + 1 : widget.toMonth}${widget.monthData[widget.startNum] < 10 ? "0${widget.monthData[widget.startNum]}" : widget.monthData[0]}");
    } else {
      print("${widget.startNum}x2");
      startDate = int.parse(
          "${widget.toYear}${widget.monthData[widget.startNum] < 10 ? widget.toMonth != 1 && widget.toMonth - 1 < 10 ? 0 : "" : widget.toMonth < 10 ? 0 : ""}${widget.monthData[widget.startNum] < 10 ? widget.toMonth == 1 ? 12 : widget.toMonth - 1 : widget.toMonth}${widget.monthData[widget.startNum] < 10 ? "0${widget.monthData[widget.startNum]}" : widget.monthData[widget.startNum]}");
    }
    print("startDate");
    print(startDate);
    for (int i = 0; i < widget.taskList.length; i++) {
      var task = widget.taskList[i];
      if (task["start_date"] < int.parse(rowEndDate) &&
          task['end_date'] > startDate) {
        tmp.add(task);
      }
    }
    print("tmp-->");
    print(tmp);
    // get List
    List<int> rowDate =
        widget.monthData.sublist(widget.startNum, widget.endNum + 1);
    // print(rowDate.toString());
    for (var task in tmp) {
      print(rowDate
          .indexOf(int.parse((task['start_date'].toString().substring(6)))));
      // if(task['start_date'].toString().substring(5))
    }
  }
}
