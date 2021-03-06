// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskDialog extends StatefulWidget {
  final String? docID;
  final String? input;
  final int? start_date;
  final int? end_date;
  const TaskDialog(
      {Key? key, this.docID, this.input, this.start_date, this.end_date})
      : super(key: key);

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  TextEditingController startDateCtl = TextEditingController();
  TextEditingController endDateCtl = TextEditingController();
  String? docID;
  String? input;
  int? start_date;
  int? end_date;
  DateTime? start_input;
  DateTime? end_input;

  @override
  void initState() {
    print("xxxxxxxxxxxx");
    print(widget.docID);
    super.initState();
  }

  Future<void> addItem({
    required int start_date,
    required int end_date,
    required String title,
  }) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('todo_tbl').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "start_date": start_date,
      "end_date": end_date,
      "title": title,
      "color": 4294901760,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));
  }

  Future<void> updateItem({
    required String title,
    required int start_date,
    required int end_date,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('todo_tbl').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "start_date": start_date,
      "end_date": end_date,
      "title": title,
      "color": 4294901760,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
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

  @override
  build(BuildContext context) async {
    return AlertDialog(
        title: Text("Add Todolist"),
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 35,
                child: TextField(
                  onChanged: (String? value) {
                    input = value;
                  },
                  decoration: InputDecoration(
                    labelText: '??????',
                    // hintText: '??????',
                    border: OutlineInputBorder(), //?????????
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 35,
                  width: 250,
                  child: TextFormField(
                      readOnly: true,
                      controller: startDateCtl,
                      decoration: InputDecoration(
                        labelText: '?????? ???',
                        border: OutlineInputBorder(), //?????????
                      ),
                      onTap: () async {
                        start_input = (await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //?????????
                            firstDate: DateTime(2021), //?????????
                            lastDate: DateTime(2023))); //????????????
                        if (start_input == null) {
                          start_date = int.parse(DateTime.now()
                              .toString()
                              .replaceAll("-", '')
                              .substring(0, 8));
                        } else {
                          startDateCtl.text = start_input
                              .toString()
                              .replaceAll("-", '')
                              .substring(0, 8);
                          start_date = int.parse(start_input
                              .toString()
                              .replaceAll("-", '')
                              .substring(0, 8));
                        }
                      })),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 35,
                  width: 250,
                  child: TextFormField(
                      readOnly: true,
                      controller: endDateCtl,
                      decoration: InputDecoration(
                        labelText: '?????? ???',
                        border: OutlineInputBorder(), //?????????
                      ),
                      onTap: () async {
                        end_input = (await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //?????????
                            firstDate: DateTime(2021), //?????????
                            lastDate: DateTime(2023))); //????????????
                        if (end_input == null) {
                          end_date = int.parse(DateTime.now()
                              .toString()
                              .replaceAll("-", '')
                              .substring(0, 8));
                        } else {
                          endDateCtl.text = end_input
                              .toString()
                              .replaceAll("-", '')
                              .substring(0, 8);
                          end_date = int.parse(end_input
                              .toString()
                              .replaceAll("-", '')
                              .substring(0, 8));
                        }
                      })),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                addItem(
                    start_date: start_date!,
                    end_date: end_date!,
                    title: input!);
                Navigator.of(context).pop();
              },
              child: Text("Add"))
        ]);
  }
}
