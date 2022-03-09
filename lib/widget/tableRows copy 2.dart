// ignore_for_file: prefer_const_constructors

import 'package:calendartodo/models/UIInfo.dart';
import 'package:calendartodo/widget/taskDialog.dart';
import 'package:flutter/material.dart';

class TableRows extends StatefulWidget {
  final int toYear;
  final int toMonth;
  final int startNum;
  final int endNum;
  final List<int> monthData;
  final List<dynamic> taskList;
  const TableRows(
      {Key? key,
      required this.startNum,
      required this.endNum,
      required this.monthData,
      required this.taskList,
      required this.toYear,
      required this.toMonth})
      : super(key: key);

  @override
  _TableRowsState createState() => _TableRowsState();
}

class _TableRowsState extends State<TableRows> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width - 16.0;
    return FutureBuilder(
        future: _setRowUIList(),
        builder: (contexta, AsyncSnapshot snapshot) {
          return Container(
            height: 100.0 +
                (snapshot.data != null && snapshot.data.length > 3
                    ? (snapshot.data.length - 3) * 25.0
                    : 0.0),
            // height: 80.0 * widget.taskList.length,

            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    width: width,
                    height: 100.0 +
                        (snapshot.data != null && snapshot.data.length > 3
                            ? (snapshot.data.length - 3) * 25.0
                            : 0.0),
                    child: Container(
                        color: Colors.grey.shade800,
                        child: Column(
                          children: [
                            Container(
                              height: 25,
                            ),
                            if (snapshot.hasData)
                              for (var item in snapshot.data)
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SizedBox(
                                    height: 20,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        for (var task in item)
                                          Expanded(
                                            flex: task.bar_length,
                                            child: SizedBox(
                                              width: double
                                                  .infinity, // color: Colors.blue,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0.0,
                                                    shadowColor:
                                                        Colors.transparent,
                                                    primary: Color(task.color),
                                                  ),
                                                  onPressed: () async {
                                                    if (task.docID != null) {
                                                      await taskDialog(
                                                          context,
                                                          task.docID,
                                                          task.title,
                                                          task.start_date,
                                                          task.end_date);
                                                    }
                                                  },
                                                  child: Text("${task.title}",
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                          ],
                        ))),
                Row(
                  children: [
                    for (var i = widget.startNum; i <= widget.endNum; i++)
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                border: Border(
                                    top: BorderSide(
                                        width: 1.0, color: Colors.white38))),
                            child: Text(
                              widget.monthData[i].toString().substring(6),
                              style: TextStyle(
                                  color: int.parse(widget.monthData[i]
                                              .toString()
                                              .substring(4, 6)) ==
                                          widget.toMonth
                                      ? Colors.white
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<List<List<UIInfo>>> _setRowUIList() async {
    List<dynamic> tasks = [];
    List<int> rowDate =
        widget.monthData.sublist(widget.startNum, widget.endNum + 1);

    for (int i = 0; i < widget.taskList.length; i++) {
      var task = widget.taskList[i];
      if (task["start_date"] <= rowDate[6] && task['end_date'] >= rowDate[0]) {
        tasks.add(task);
      }
    }
    List<List<UIInfo>> taskUIList = [];
    // print(rowDate);

    for (int j = 0; j < tasks.length; j++) {
      var task = tasks[j];
      List<UIInfo> tmp = [];
      for (var i = 0; i < 7; i++) {
        tmp.add(UIInfo(null, null, null, '', '', 0xFF424242, 0));
      }
      // start date가 이번주가 아닌경우 (이 전에 시작된 일정)
      if (!rowDate.contains(task['start_date'])) {
        // 이번 주 종료 일정이 아닌 경우
        if (!rowDate.contains(task['end_date'])) {
          // 7칸 전부 색칠
          for (var i = 0; i < 7; i++) {
            tmp[i] = UIInfo(task['start_date'], task['end_date'], task['id'],
                task['title'], '', task['color'], 0);
          }
          // tmp.asMap().forEach((index, element) async {
          //   element = UIInfo(task['start_date'], task['end_date'], task['id'],
          //       task['title'], '', task['color'], 0);
          // });
        } else {
          // 이번주 종료 이벤트 인덱스가 0부터 시작이기 때문에 +1
          for (var i = 0; i < rowDate.indexOf(task['end_date']); i++) {
            tmp[i] = UIInfo(task['start_date'], task['end_date'], task['id'],
                task['title'], '', task['color'], 0);
          }
          // tmp.asMap().forEach((index, element) async {
          //   if (rowDate.indexOf(task['end_date']) <= index) {
          //     element = UIInfo(task['start_date'], task['end_date'], task['id'],
          //         task['title'], '', task['color'], 0);
          //   }
          // });
        }
      } else {
        // 시작 인덱스가 0이면 1로 주기
        if (rowDate.indexOf(task['start_date']) == 0) {
          //끝도 0 이라면
          if (rowDate.indexOf(task['end_date']) == 0) {
            tmp[0] = UIInfo(task['start_date'], task['end_date'], task['id'],
                task['title'], '', task['color'], 0);
          } else {
            if (!rowDate.contains(task['end_date'])) {
              //시작이 0이면서 끝이 포함되지 않으면
              tmp.asMap().forEach((index, element) async {
                element = UIInfo(task['start_date'], task['end_date'],
                    task['id'], task['title'], '', task['color'], 0);
              });
            } else {
              tmp.asMap().forEach((index, element) async {
                if (rowDate.indexOf(task['end_date']) <= index) {
                  element = UIInfo(task['start_date'], task['end_date'],
                      task['id'], task['title'], '', task['color'], 0);
                }
              });
            }
          }
        } else {
          // 마지막 날짜 포함하지 않았을 경우
          if (!rowDate.contains(task['end_date'])) {
            tmp.asMap().forEach((index, element) async {
              if (rowDate.indexOf(task['end_date']) >
                  7 - rowDate.indexOf(task['start_date'])) {
                element = UIInfo(task['start_date'], task['end_date'],
                    task['id'], task['title'], '', task['color'], 0);
              }
            });
          } else if (rowDate.indexOf(task['end_date']) -
                  rowDate.indexOf(task['start_date']) ==
              0) {
            //포함일 경우 1일짜리 task일 때
            tmp.asMap().forEach((index, element) async {
              if (index == rowDate.indexOf(task['start_date'])) {
                element = UIInfo(task['start_date'], task['end_date'],
                    task['id'], task['title'], '', task['color'], 0);
              }
            });
          } else {
            //여러 날짜일 경우
            // for (var element in tmp) { }

            tmp.asMap().forEach((index, element) async {
              if (rowDate.indexOf(task['start_date']) <= index &&
                  rowDate.indexOf(task['end_date']) >= index) {
                element = UIInfo(task['start_date'], task['end_date'],
                    task['id'], task['title'], '', task['color'], 0);
              }
            });
          }
        }
        // end_date가 포함되지 않았을 경우 (종료 일이 이번 주가 아닌 경우)
        // if (!rowDate.contains(task['end_date'])) {
        for (var element in tmp) {
          print("element");
          print(element.title);
        }
      }
      // print(tmp);
    }

    // print(taskUIList);
    return taskUIList;
  }
}
