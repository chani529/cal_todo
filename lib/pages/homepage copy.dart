// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calendartodo/widget/table.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List todos = [];
  String input = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Study"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CalTable(),
        ));
  }

  // static Stream<QuerySnapshot> readItems() {
  //   CollectionReference notesItemCollection =
  //       FirebaseFirestore.instance.collection('task_list');

  //   return notesItemCollection.snapshots();
  // }

  // Future<void> addItem({
  //   required String title,
  // }) async {
  //   DocumentReference documentReferencer =
  //       FirebaseFirestore.instance.collection('task_list').doc();

  //   Map<String, dynamic> data = <String, dynamic>{
  //     "title": title,
  //   };

  //   await documentReferencer
  //       .set(data)
  //       .whenComplete(() => print("Notes item added to the database"))
  //       .catchError((e) => print(e));
  // }

  // Future<void> deleteItem({
  //   required String docId,
  // }) async {
  //   DocumentReference documentReferencer =
  //       FirebaseFirestore.instance.collection('task_list').doc(docId);

  //   await documentReferencer
  //       .delete()
  //       .whenComplete(() => print('Note item deleted from the database'))
  //       .catchError((e) => print(e));
  // }
}
