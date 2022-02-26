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
    Future<List<dynamic>> abcd =
        tests(toYear: toYear, toMonth: toMonth, monthData: monthData);
    Stream<QuerySnapshot> taskList =
        readItems(toYear: toYear, toMonth: toMonth, monthData: monthData);

    // @override
    // void initState() {
    //   getData();
    //   super.initState();
    // }
    /*24 is for notification bar on Android*/
    return Container(
      constraints: BoxConstraints(
        minHeight: 100,
      ),
      child: Column(
        children: [
          // TableRows(
          //     startNum: 0, endNum: 6, monthData: monthData, taskList: taskList),
          // startNum: 0, endNum: 6, monthData: monthData, taskList: filterList(toYear: toYear,toMonth: toMonth,endNum:6,monthData: monthData,taskList: taskList),
          // TableRows(
          //     startNum: 7,
          //     endNum: 13,
          //     monthData: monthData,
          //     taskList: filterList(
          //         toYear: toYear,
          //         toMonth: toMonth,
          //         endNum: 13,
          //         monthData: monthData,
          //         taskList: taskList)),
          // TableRows(
          //     startNum: 14,
          //     endNum: 20,
          //     monthData: monthData,
          //     taskList: filterList(
          //         toYear: toYear,
          //         toMonth: toMonth,
          //         endNum: 20,
          //         monthData: monthData,
          //         taskList: taskList)),
          // TableRows(
          //     startNum: 21,
          //     endNum: 27,
          //     monthData: monthData,
          //     taskList: filterList(
          //         toYear: toYear,
          //         toMonth: toMonth,
          //         endNum: 27,
          //         monthData: monthData,
          //         taskList: taskList)),
          // TableRows(
          //     startNum: 28,
          //     endNum: 34,
          //     monthData: monthData,
          //     taskList: filterList(
          //         toYear: toYear,
          //         toMonth: toMonth,
          //         endNum: 34,
          //         monthData: monthData,
          //         taskList: taskList)),
          // TableRows(
          //     startNum: 35,
          //     endNum: 41,
          //     monthData: monthData,
          //     taskList: filterList(
          //         toYear: toYear,
          //         toMonth: toMonth,
          //         endNum: 41,
          //         monthData: monthData,
          //         taskList: taskList)),
          FutureBuilder(
              future: abcd,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      snapshot.data.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }
              }),
          TextButton(
              onPressed: () {
                // addItem(start_date: 20220228);
              },
              child: Text(abcd.toString()))
        ],
      ),
    );
  }

  static Future<List> tests(
      {required int toYear,
      required int toMonth,
      required List<int> monthData}) async {
    Iterable<Set<Map>> tempDoc;
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('todo_tbl')
        .where('end_date',
            isGreaterThanOrEqualTo: int.parse(
                "${monthData[0] != 1 && toMonth == 1 ? toYear - 1 : toYear}${monthData[0] != 1 ? toMonth != 1 && toMonth - 1 < 10 ? 0 : "" : toMonth < 10 ? 0 : ""}${monthData[0] != 1 ? toMonth == 1 ? 12 : toMonth - 1 : toMonth}${monthData[0] == 1 ? 01 : monthData[0]}"))
        .get()
        .then((querySnapshot) => {
              tempDoc = querySnapshot.docs.map((doc) => {
                    {'id': doc.id, ...doc.data()}
                  })
            });
    // .where('end_date',
    //     isGreaterThanOrEqualTo: int.parse(
    //         "${monthData[0] != 1 && toMonth == 1 ? toYear - 1 : toYear}${monthData[0] != 1 ? toMonth != 1 && toMonth - 1 < 10 ? 0 : "" : toMonth < 10 ? 0 : ""}${monthData[0] != 1 ? toMonth == 1 ? 12 : toMonth - 1 : toMonth}${monthData[0] == 1 ? 01 : monthData[0]}"));
    // firebase 다른필드에 부등호 못씀........
    // .where('start_date', isLessThan: 20220312);

    // .where('end_date',
    //     isGreaterThanOrEqualTo: int.parse(
    //         "${monthData[0] != 1 && toMonth == 1 ? toYear - 1 : toYear}${monthData[0] != 1 ? toMonth != 1 && toMonth - 1 < 10 ? 0 : "" : toMonth < 10 ? 0 : ""}${monthData[0] != 1 ? toMonth == 1 ? 12 : toMonth - 1 : toMonth}${monthData[0] == 1 ? 01 : monthData[0]}"));
    // firebase 다른필드에 부등호 못씀........
    // .where('start_date', isLessThan: 20220312);
    print("sssxxxx");
    print("xx");
    var tmp = [];
    print(documentSnapshot.map((e) => e.map((e) => e.map((e) => tmp.add(e)))));
    print(tmp[0]);
    return tmp;
  }

  static Stream<QuerySnapshot> readItems(
      {required int toYear,
      required int toMonth,
      required List<int> monthData}) {
    // print("xx");
    // print(
    //     "${monthData[0] != 1 && toMonth == 1 ? toYear - 1 : toYear}${monthData[0] != 1 ? toMonth != 1 && toMonth - 1 < 10 ? 0 : "" : toMonth < 10 ? 0 : ""}${monthData[0] != 1 ? toMonth == 1 ? 12 : toMonth - 1 : toMonth}${monthData[0] == 1 ? 01 : monthData[0]}");
    Query<Map<String, dynamic>> notesItemCollection = FirebaseFirestore.instance
        .collection('todo_tbl')
        .where('end_date',
            isGreaterThanOrEqualTo: int.parse(
                "${monthData[0] != 1 && toMonth == 1 ? toYear - 1 : toYear}${monthData[0] != 1 ? toMonth != 1 && toMonth - 1 < 10 ? 0 : "" : toMonth < 10 ? 0 : ""}${monthData[0] != 1 ? toMonth == 1 ? 12 : toMonth - 1 : toMonth}${monthData[0] == 1 ? 01 : monthData[0]}"));
    // firebase 다른필드에 부등호 못씀........
    // .where('start_date', isLessThan: 20220312);
    // notesItemCollection.snapshots().
    return notesItemCollection.snapshots();
  }

  static List<TaskInfo> filterList(
      {required Stream<QuerySnapshot> taskList,
      required int toYear,
      required int toMonth,
      required int endNum,
      required List<int> monthData}) {
    List<TaskInfo> tmp = [];
    var rowEndDate = '';
    rowEndDate = (toMonth == 12 && endNum >= 20 && monthData[endNum] < 10
            ? toYear + 1
            : toYear)
        .toString();
    var tmpMonth;
    if (endNum >= 20 && monthData[endNum] < 10) {
      tmpMonth = toMonth + 1 > 12 ? 1 : toMonth + 1;
    } else {
      tmpMonth = toMonth;
    }
    rowEndDate += tmpMonth < 10 ? "0$tmpMonth".toString() : tmpMonth.toString();
    rowEndDate += monthData[endNum] < 10
        ? "0${monthData[endNum]}"
        : monthData[endNum].toString();
    // print("rowEndDate");
    // print(rowEndDate);
    // print(taskList);

    // print(tmp);
    // for (QuerySnapshot value in taskList) {
    //   // print("xx");
    //   tmp = value.docs.where((e) {
    //     return e["start_date"] <= int.parse(rowEndDate);
    //   });
    //   print(tmp);
    // }
    // taskList.transform(streamTransformer)
    taskList.listen((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((document) => {
            if (document['start_date'] <= int.parse(rowEndDate))
              {
                print(document['start_date']),
                tmp.add(TaskInfo(document['start_date'], document['end_date'],
                    "", "", "red", "chani", "20220222"))
              }
          });
      print("xxxxxxxxxxxxxxxxxxx");
      print(tmp);
    });
    return tmp;
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
