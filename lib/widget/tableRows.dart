// ignore_for_file: prefer_const_constructors

import 'package:calendartodo/models/taskInfo.dart';
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
    );
  }
}
