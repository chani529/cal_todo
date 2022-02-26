// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calendartodo/util/getMonthFunction.dart';
import 'package:flutter/material.dart';
import 'package:calendartodo/widget/tableRows.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalTable extends StatefulWidget {
  const CalTable({Key? key}) : super(key: key);

  @override
  _CalTableState createState() => _CalTableState();
}

class _CalTableState extends State<CalTable> {
  @override
  Widget build(BuildContext context) {
    final int toYear = 2022;
    final int toMonth = 2;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // print(height);
    // print(width);
    UtilFunction func = UtilFunction();
    List<int> monthData = func.getMounthList(toYear, toMonth);
    Stream<QuerySnapshot> taskList =
        readItems(toYear: toYear, toMonth: toMonth, monthData: monthData);
    /*24 is for notification bar on Android*/
    return Container(
      constraints: BoxConstraints(
        minHeight: 100,
      ),
      child: Column(
        children: [
          TableRows(
              startNum: 0, endNum: 6, monthData: monthData, taskList: taskList),
          TableRows(
              startNum: 7,
              endNum: 13,
              monthData: monthData,
              taskList: taskList),
          TableRows(
              startNum: 14,
              endNum: 20,
              monthData: monthData,
              taskList: taskList),
          TableRows(
              startNum: 21,
              endNum: 27,
              monthData: monthData,
              taskList: taskList),
          TableRows(
              startNum: 28,
              endNum: 34,
              monthData: monthData,
              taskList: taskList),
          TableRows(
              startNum: 35,
              endNum: 41,
              monthData: monthData,
              taskList: taskList),
          TextButton(
              onPressed: () {
                addItem(start_date: 20220228);
              },
              child: Text("Add"))
        ],
      ),
    );
  }

  static Stream<QuerySnapshot> readItems(
      {required int toYear,
      required int toMonth,
      required List<int> monthData}) {
    print("xx");
    print(
        "${monthData[0] != 1 && toMonth == 1 ? toYear - 1 : toYear}${monthData[0] != 1 ? toMonth != 1 && toMonth - 1 < 10 ? 0 : "" : toMonth < 10 ? 0 : ""}${monthData[0] != 1 ? toMonth == 1 ? 12 : toMonth - 1 : toMonth}${monthData[0] == 1 ? 01 : monthData[0]}");
    Query<Map<String, dynamic>> notesItemCollection = FirebaseFirestore.instance
        .collection('todo_tbl')
        .where('start_date',
            isGreaterThan:
                "${monthData[0] != 1 && toMonth == 1 ? toYear - 1 : toYear}${monthData[0] != 1 ? toMonth != 1 && toMonth - 1 < 10 ? 0 : "" : toMonth < 10 ? 0 : ""}${monthData[0] != 1 ? toMonth == 1 ? 12 : toMonth - 1 : toMonth}${monthData[0] == 1 ? 01 : monthData[0]}")
        .where('start_date', isLessThanOrEqualTo: 20220220);

    return notesItemCollection.snapshots();
  }

  Future<void> addItem({
    required int start_date,
  }) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('todo_tbl').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "start_date": start_date,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));
  }

  Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('todo_tbl').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
