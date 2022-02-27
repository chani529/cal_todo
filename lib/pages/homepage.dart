// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calendartodo/widget/table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int start_input = 0;
  int end_input = 0;
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Add Todolist"),
                    content: Column(
                      children: [
                        TextField(
                          onChanged: (String value) {
                            input = value;
                          },
                          decoration: InputDecoration(
                            // labelText: '텍스트 입력',
                            hintText: '제목',
                            border: OutlineInputBorder(), //외곽선
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            startDatePickerPop();
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                              width: 3,
                              color: Colors.amberAccent,
                            )),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              start_input == 0
                                  ? '시작 일'
                                  : start_input.toString(),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            endDatePickerPop();
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                              width: 3,
                              color: Colors.amberAccent,
                            )),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              end_input == 0 ? '종료 일' : end_input.toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            addItem(
                                start_date: start_input,
                                end_date: end_input,
                                title: input);
                            Navigator.of(context).pop();
                            setState(() {
                              start_input = 0;
                              end_input = 0;
                              input = '';
                            }); // input 입력 후 창 닫히도록
                          },
                          child: Text("Add"))
                    ]);
              })
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
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

  void startDatePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(), //초기값
      firstDate: DateTime(2021), //시작일
      lastDate: DateTime(2023), //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );
    selectedDate.then((dateTime) {
      start_input =
          int.parse(dateTime.toString().replaceAll("-", '').substring(0, 8));
      print(dateTime.toString().replaceAll("-", '').substring(0, 8));
    });
  }

  void endDatePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(), //초기값
      firstDate: DateTime(2021), //시작일
      lastDate: DateTime(2023), //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );
    selectedDate.then((dateTime) {
      end_input =
          int.parse(dateTime.toString().replaceAll("-", '').substring(0, 8));
      print(dateTime.toString().replaceAll("-", '').substring(0, 8));
    });
  }
}
