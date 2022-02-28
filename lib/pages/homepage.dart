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
  TextEditingController startDateCtl = TextEditingController();
  TextEditingController endDateCtl = TextEditingController();
  DateTime? start_input;
  DateTime? end_input;
  int? start_date = 0;
  int? end_date = 0;
  String input = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(child: CalTable()),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 35,
                            child: TextField(
                              onChanged: (String value) {
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
                                title: input);
                            Navigator.of(context).pop();
                            setState(() {
                              start_input = null;
                              end_input = null;
                              input = '';
                            }); // input 입력 후 창 닫히도록
                          },
                          child: Text("Add"))
                    ]);
              }).then((value) {
            start_input = null;
            start_date = null;
            end_input = null;
            end_date = null;
            startDateCtl.text = '';
            endDateCtl.text = '';
            input = '';
            return null;
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

  // void startDatePickerPop() {
  //   Future<DateTime?> selectedDate = showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(), //초기값
  //     firstDate: DateTime(2021), //시작일
  //     lastDate: DateTime(2023), //마지막일
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: ThemeData.dark(), //다크 테마
  //         child: child!,
  //       );
  //     },
  //   );
  //   selectedDate.then((dateTime) {
  //     start_input =
  //         int.parse(dateTime.toString().replaceAll("-", '').substring(0, 8));
  //     print(dateTime.toString().replaceAll("-", '').substring(0, 8));
  //   });
  // }

  // void endDatePickerPop() {
  //   Future<DateTime?> selectedDate = showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(), //초기값
  //     firstDate: DateTime(2021), //시작일
  //     lastDate: DateTime(2023), //마지막일
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: ThemeData.dark(), //다크 테마
  //         child: child!,
  //       );
  //     },
  //   );
  //   selectedDate.then((dateTime) {
  //     setState(() {
  //       end_input =
  //           int.parse(dateTime.toString().replaceAll("-", '').substring(0, 8));
  //       print(dateTime.toString().replaceAll("-", '').substring(0, 8));
  //     });
  //   });
  // }
}
