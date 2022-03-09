// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SetTaskDialog extends StatefulWidget {
  final String? docID;
  final String? input;
  final int? start_date;
  final int? end_date;

  const SetTaskDialog(
      {Key? key,
      required this.docID,
      required this.input,
      required this.start_date,
      required this.end_date})
      : super(key: key);

  @override
  State<SetTaskDialog> createState() => _SetTaskDialogState();
}

class _SetTaskDialogState extends State<SetTaskDialog> {
  TextEditingController inputDateCtl = TextEditingController();
  TextEditingController startDateCtl = TextEditingController();
  TextEditingController endDateCtl = TextEditingController();
  DateTime? _start_input;
  DateTime? _end_input;
  int? startDate;
  int? endDate;
  String? _input;
  String _dropdownValue = 'Red';
  @override
  void initState() {
    if (widget.docID != null) {
      startDate = widget.start_date;
      endDate = widget.end_date;
      _start_input = DateTime(
          int.parse(widget.start_date.toString().substring(0, 4)),
          int.parse(widget.start_date.toString().substring(4, 6)),
          int.parse(widget.start_date.toString().substring(6)));
      _end_input = DateTime(
          int.parse(widget.end_date.toString().substring(0, 4)),
          int.parse(widget.end_date.toString().substring(4, 6)),
          int.parse(widget.end_date.toString().substring(6)));
      inputDateCtl.text = widget.input!;
      startDateCtl.text = widget.start_date.toString();
      endDateCtl.text = widget.end_date.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    _input = value;
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
                        _start_input = (await showDatePicker(
                            context: context,
                            initialDate: _start_input ?? DateTime.now(), //초기값
                            firstDate: DateTime(2021), //시작일
                            lastDate: DateTime(2023))); //마지막일
                        if (_start_input == null) {
                          startDate = int.parse(DateTime.now()
                              .toString()
                              .replaceAll("-", '')
                              .substring(0, 8));
                        } else {
                          startDateCtl.text = _start_input
                              .toString()
                              .replaceAll("-", '')
                              .substring(0, 8);
                          startDate = int.parse(_start_input
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
                        _end_input = (await showDatePicker(
                            context: context,
                            initialDate: _end_input ?? DateTime.now(), //초기값
                            firstDate: DateTime(2021), //시작일
                            lastDate: DateTime(2023))); //마지막일
                        if (_end_input == null) {
                          endDate = int.parse(DateTime.now()
                              .toString()
                              .replaceAll("-", '')
                              .substring(0, 8));
                        } else {
                          endDateCtl.text = _end_input
                              .toString()
                              .replaceAll("-", '')
                              .substring(0, 8);
                          endDate = int.parse(_end_input
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
                      border:
                          Border.all(width: 1, color: Colors.green.shade400),
                      borderRadius: BorderRadius.all(Radius.circular(5)) //외곽선
                      ),
                  child: DropdownButton<String>(
                    value: _dropdownValue,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValue = newValue!;
                      });
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
          if (widget.docID != null)
            TextButton(
                onPressed: () {
                  deleteItem(docId: widget.docID!);
                  Navigator.of(context).pop();
                },
                child: Text("Delete")),
          if (widget.docID != null)
            TextButton(
                onPressed: () {
                  updateItem(
                      start_date: startDate!,
                      end_date: endDate!,
                      title: _input!,
                      docId: widget.docID!,
                      color: _dropdownValue);
                  Navigator.of(context).pop();
                },
                child: Text("Update")),
          if (widget.docID == null)
            TextButton(
                onPressed: () {
                  addItem(
                      start_date: startDate!,
                      end_date: endDate!,
                      title: _input!,
                      color: _dropdownValue);
                  Navigator.of(context).pop();
                },
                child: Text("Add")),
        ]);
  }

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
}
