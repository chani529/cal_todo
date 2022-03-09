// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

taskDialog(BuildContext context, String? docID, String? input, int? start_date,
    int? end_date) async {
  TextEditingController inputDateCtl = TextEditingController();
  TextEditingController startDateCtl = TextEditingController();
  TextEditingController endDateCtl = TextEditingController();
  DateTime? start_input;
  DateTime? end_input;
  String dropdownValue = 'Red';
  if (docID != null) {
    inputDateCtl.text = input!;
    startDateCtl.text = start_date.toString();
    endDateCtl.text = end_date.toString();
  }

  // int? start_date = 0;
  // int? end_date = 0;
  // String input = "";

  Future<void> addItem(
      {required int start_date,
      required int end_date,
      required String title,
      required String color}) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('todo_tbl').doc();
    int colorNum;
    if (color == 'Red') {
      colorNum = 4294901760;
    } else if (color == 'Yellow') {
      colorNum = 4294963574;
    } else if (color == 'Blue') {
      colorNum = 4280391411;
    } else {
      colorNum = 4284922730;
    }
    Map<String, dynamic> data = <String, dynamic>{
      "start_date": start_date,
      "end_date": end_date,
      "title": title,
      "color": colorNum,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));
  }

  Future<void> updateItem(
      {required String title,
      required int start_date,
      required int end_date,
      required String docId,
      required String color}) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('todo_tbl').doc(docId);
    int colorNum;
    if (color == 'Red') {
      colorNum = 4294901760;
    } else if (color == 'Yellow') {
      colorNum = 4294963574;
    } else if (color == 'Blue') {
      colorNum = 4280391411;
    } else {
      colorNum = 4284922730;
    }
    Map<String, dynamic> data = <String, dynamic>{
      "start_date": start_date,
      "end_date": end_date,
      "title": title,
      "color": colorNum,
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

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Add Todolist"),
            content: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 35,
                    child: TextField(
                      controller: inputDateCtl,
                      onChanged: (String? value) {
                        input = value;
                      },
                      decoration: InputDecoration(
                        labelText: '제목',
                        // hintText: '제목',
                        border: OutlineInputBorder(), //외곽선
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
                            labelText: '시작 일',
                            border: OutlineInputBorder(), //외곽선
                          ),
                          onTap: () async {
                            start_input = (await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), //초기값
                                firstDate: DateTime(2021), //시작일
                                lastDate: DateTime(2023))); //마지막일
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
                            labelText: '종료 일',
                            border: OutlineInputBorder(), //외곽선
                          ),
                          onTap: () async {
                            end_input = (await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), //초기값
                                firstDate: DateTime(2021), //시작일
                                lastDate: DateTime(2023))); //마지막일
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
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 35,
                      width: 250,
                      padding: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                          // hintText: '제목',
                          border: Border.all(
                              width: 1, color: Colors.green.shade400),
                          borderRadius:
                              BorderRadius.all(Radius.circular(5)) //외곽선
                          ),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        onChanged: (String? newValue) {
                          dropdownValue = newValue!;
                        },
                        items: <String>['Red', 'Blue', 'Green', 'Yellow']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
              ],
            ),
            actions: <Widget>[
              if (input != null)
                TextButton(
                    onPressed: () {
                      deleteItem(docId: docID!);
                      Navigator.of(context).pop();
                    },
                    child: Text("Delete")),
              if (input != null)
                TextButton(
                    onPressed: () {
                      updateItem(
                          start_date: start_date!,
                          end_date: end_date!,
                          title: input!,
                          docId: docID!,
                          color: dropdownValue);
                      Navigator.of(context).pop();
                    },
                    child: Text("Update")),
              if (input == null)
                TextButton(
                    onPressed: () {
                      addItem(
                          start_date: start_date!,
                          end_date: end_date!,
                          title: input!,
                          color: dropdownValue);
                      Navigator.of(context).pop();
                    },
                    child: Text("Add")),
            ]);
      });
}
