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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // print(height);
    // print(width);
    UtilFunction func = new UtilFunction();
    List<int> monthData = func.getMounthList(2022, 2);
    readItems();
    /*24 is for notification bar on Android*/
    return StreamBuilder(
        stream: readItems(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final _todoInfo = snapshot.data!.docs;
            print(snapshot.data.docs);
            return ListView.builder(
                itemCount: _todoInfo.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                      // 삭제 버튼 및 기능 추가
                      key: Key(_todoInfo[index]['start_date'].toString()),
                      child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            title:
                                Text(_todoInfo[index]['start_date'].toString()),
                            trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  deleteItem(docId: _todoInfo[index].id);
                                }),
                          )));
                });
          } else {
            return Text("ss");
          }
        });
  }

  static Stream<QuerySnapshot> readItems() {
    Query<Map<String, dynamic>> notesItemCollection = FirebaseFirestore.instance
        .collection('todo_tbl')
        .where('start_date', isGreaterThanOrEqualTo: 20200211)
        .where('start_date', isLessThanOrEqualTo: 20220220);
    return notesItemCollection.snapshots();
  }

  Future<void> addItem({
    required Timestamp start_date,
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
