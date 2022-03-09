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
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return SetTaskDialog(
                                                            docID: task.docID,
                                                            end_date:
                                                                task.end_date,
                                                            input: task.title,
                                                            start_date:
                                                                task.start_date,
                                                          );
                                                        },
                                                      );
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
    List<List<int>> taskLists = [];
    List<List<UIInfo>> taskUIList = [];
    // print(rowDate);
    for (int a = 0; a < tasks.length; a++) {
      List<int> checkTaskDate = [0, 0, 0, 0, 0, 0, 0];
      var task = tasks[a];
      List<UIInfo> tmp = [];
      for (var i = 0; i < 7; i++) {
        tmp.add(UIInfo(null, null, null, '', '', 0xFF424242, 0));
      }
      // start date가 이번주가 아닌경우 (이 전에 시작된 일정)
      for (var i = (rowDate.contains(task['start_date'])
              ? rowDate.indexOf(task['start_date'])
              : 0);
          i <=
              (rowDate.contains(task['end_date'])
                  ? rowDate.indexOf(task['end_date'])
                  : 6);
          i++) {
        tmp[i] = UIInfo(task['start_date'], task['end_date'], task['id'],
            task['title'], '', task['color'], 0);
        checkTaskDate[i] = 1;
      }
      // print(checkTaskDate.join(', '));
      taskLists.add(checkTaskDate);
      int taskNum = 0;
      bool checkMerge = true;
      // print("xxx");
      // print(taskLists.length.toString());
      for (var i = 0; i < taskLists.length; i++) {
        checkMerge = true;

        for (var j = 0; j < 7; j++) {
          // print(
          //     'i : ${i},j : ${j} check ${checkTaskDate[j]} , task ${taskLists[i][j]}');
          if (checkTaskDate[j] == 1 && taskLists[i][j] == 1) {
            checkMerge = false;
            break;
          }
        }
        if (checkMerge) {
          taskNum = i;
          break;
        }
      }
      // print("taskNum.toString()");
      // print(taskNum.toString());
      // print(checkMerge);
      if (checkMerge) {
        for (var k = (rowDate.contains(task['start_date'])
                ? rowDate.indexOf(task['start_date'])
                : 0);
            k <=
                (rowDate.contains(task['end_date'])
                    ? rowDate.indexOf(task['end_date'])
                    : 6);
            k++) {
          taskUIList[taskNum][k] = UIInfo(task['start_date'], task['end_date'],
              task['id'], task['title'], '', task['color'], 0);
          taskLists[taskNum][k] = 1;
        }
        taskLists.removeAt(taskLists.length - 1);
      } else {
        taskUIList.add(tmp);
      }
    }

    List<List<UIInfo>> resultTaskUIList = [];
    for (var i = 0; i < taskUIList.length; i++) {
      List<UIInfo> tmp = taskUIList[i];
      List<int> removeList = [];
      for (var i = 0; i < 7; i++) {
        tmp[i].bar_length = 1;
        if (tmp[i].title != 'RemoveTaskJob') {
          for (var j = i + 1; j < 7; j++) {
            if (tmp[i].title == tmp[j].title) {
              tmp[i].bar_length = tmp[i].bar_length + 1;
              tmp[j].title = 'RemoveTaskJob';
              removeList.add(j);
            } else {
              break;
            }
          }
        }
      }
      for (var k = removeList.length - 1; k >= 0; k--) {
        // print(removeList[k]);
        tmp.removeAt(removeList[k]);
      }
      resultTaskUIList.add(tmp);
    }

    // print(taskUIList);
    return resultTaskUIList;
  }
}
