// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TableRows extends StatefulWidget {
  final int startNum;
  final int endNum;
  final List<int> monthData;
  final Stream<QuerySnapshot> taskList;
  const TableRows(
      {Key? key,
      required this.startNum,
      required this.endNum,
      required this.monthData,
      required this.taskList})
      : super(key: key);

  @override
  _TableRowsState createState() => _TableRowsState();
}

class _TableRowsState extends State<TableRows> {
  @override
  void initState() {
    _getPresentTaskList();
    super.initState();
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
                    child: Container(
                      child: Text(widget.monthData[i].toString()),
                    ),
                  ),
                ),
            ],
          ),
          Positioned(
              top: 0,
              left: 0,
              width: width,
              height: 100,
              child: Column(
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                        // color: Colors.black,
                        border: Border.all(width: 1, color: Colors.blue)),
                  ),
                  for (var i = 0; i < 3; i++)
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                          // color: Colors.black,
                          border: Border.all(width: 1, color: Colors.blue)),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Container(
                              color: Colors.blue,
                              child: Text("[VRIS] 모시깽이 작업"),
                            ),
                          )

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

  Future<void> _getPresentTaskList() async {
    await for (QuerySnapshot value in widget.taskList) {
      // print("xx");
      var tmp = value.docs.where((e) {
        // print(e["start_date"]);
        return e["start_date"] >=
            int.parse(widget.monthData[widget.startNum] < 10
                ? "2022020${widget.monthData[widget.startNum]}"
                : "202202${widget.monthData[widget.startNum]}");
      });
      // tmp.forEach((element) {
      //   print(element['start_date']);
      // });
    }
  }
}
