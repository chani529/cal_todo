// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:calendartodo/models/taskInfo.dart';
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
  int toYear = 2022;
  int toMonth = 2;
  // void _incrementcs() {
  //   // 플러터 메서드에 내장
  Future<List<dynamic>>? abcd = null;
  Stream<QuerySnapshot>? taskList = null;
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<String> _week = ['S', 'M', "T", "W", "T", "F", "S"];
    // setState(() {

    // });
    UtilFunction func = UtilFunction();
    List<int> monthData = func.getMounthList(toYear, toMonth);
    abcd = tests(toYear: toYear, toMonth: toMonth, monthData: monthData);
    taskList = readItems(
        toYear: toYear, toMonth: toMonth, monthData: monthData, abcd: abcd!);
    // print(height);
    // print(width);

    // @override
    // void initState() {
    //   super.initState();
    // }

    /*24 is for notification bar on Android*/
    return Container(
      constraints: BoxConstraints(
        minHeight: 100,
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                color: Colors.grey.shade800),
            child: Stack(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        onPressed: () => setState(() => toMonth--),
                        child: Text("<",
                            style:
                                TextStyle(fontSize: 25, color: Colors.white)),
                      ),
                      Text("$toYear / $toMonth",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () => setState(() => toMonth++),
                        child: Text(">",
                            style:
                                TextStyle(fontSize: 25, color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
                color: Colors.grey.shade800,
                border:
                    Border(top: BorderSide(width: 1.0, color: Colors.white38))),
            child: Row(
              children: [
                for (var item in _week)
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
          FutureBuilder(
              future: abcd,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // print("bbbbb");
                //데이터 다시받아오는 부분
                taskList?.listen((QuerySnapshot querySnapshot) {
                  for (var i in querySnapshot.docChanges) {
                    if (i.type == DocumentChangeType.added) {
                      if (mounted) {
                        setState(() {});
                      }
                    }
                  }
                });
                //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                // switch (snapshot.connectionState) {
                //   case ConnectionState.none:
                //     abcd = tests(
                //         toYear: toYear, toMonth: toMonth, monthData: monthData);

                //     return Text('loading...');
                //   case ConnectionState.waiting:
                //     return Text('loading...');
                //   default:
                if (snapshot.hasData == false) {
                  return CircularProgressIndicator();
                }

                //error가 발생하게 될 경우 반환하게 되는 부분
                else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }
                // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                else {
                  return Column(
                    children: [
                      TableRows(
                          startNum: 0,
                          endNum: 6,
                          monthData: monthData,
                          taskList: snapshot.data,
                          toMonth: toMonth,
                          toYear: toYear),
                      TableRows(
                          startNum: 7,
                          endNum: 13,
                          monthData: monthData,
                          taskList: snapshot.data,
                          toMonth: toMonth,
                          toYear: toYear),
                      TableRows(
                          startNum: 14,
                          endNum: 20,
                          monthData: monthData,
                          taskList: snapshot.data,
                          toMonth: toMonth,
                          toYear: toYear),
                      TableRows(
                          startNum: 21,
                          endNum: 27,
                          monthData: monthData,
                          taskList: snapshot.data,
                          toMonth: toMonth,
                          toYear: toYear),
                      TableRows(
                          startNum: 28,
                          endNum: 34,
                          monthData: monthData,
                          taskList: snapshot.data,
                          toMonth: toMonth,
                          toYear: toYear),
                      TableRows(
                          startNum: 35,
                          endNum: 41,
                          monthData: monthData,
                          taskList: snapshot.data,
                          toMonth: toMonth,
                          toYear: toYear),
                    ],
                  );
                }
              }
              // }
              ),
        ],
      ),
    );
  }

  static Future<List> tests(
      {required int toYear,
      required int toMonth,
      required List<int> monthData}) async {
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('todo_tbl')
        .where('end_date', isGreaterThanOrEqualTo: monthData[0])
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.map((doc) => {
                    {'id': doc.id, ...doc.data()}
                  })
            });

    var tmp = [];
    for (var e in documentSnapshot) {
      for (var e in e) {
        for (var e in e) {
          tmp.add(e);
        }
      }
    }
    // print(tmp);

    return tmp;
  }

  static Stream<QuerySnapshot> readItems(
      {required int toYear,
      required int toMonth,
      required List<int> monthData,
      required Future<List<dynamic>> abcd}) {
    Query<Map<String, dynamic>> notesItemCollection = FirebaseFirestore.instance
        .collection('todo_tbl')
        .where('end_date', isGreaterThanOrEqualTo: monthData[0]);
    // firebase 다른필드에 부등호 못씀........
    // .where('start_date', isLessThan: 20220312);

    // notesItemCollection.snapshots().listen((event) {
    //   setState(() {abcd =
    //         tests(toYear: toYear, toMonth: toMonth, monthData: monthData);
    //   });
    // });
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
