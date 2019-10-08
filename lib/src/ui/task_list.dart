import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_2/src/bloc/task_list_bloc.dart';
import 'package:flutter_todo_2/src/database/models/item_task.dart';
import 'package:flutter_todo_2/src/database/models/item_task_new.dart';
import 'package:intl/intl.dart';

import 'add_task_view.dart';

class TaskList extends StatefulWidget {
  List<ItemTaskNew> taskList;
  TaskListBloc taskListBloc;

  TaskList(
    this.taskListBloc,
    List<ItemTaskNew> this.taskList, {
    Key key,
  }) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        itemCount: widget.taskList == null ? 0 : widget.taskList.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            elevation: 0,
            child: new Container(
              child: Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            widget.taskList[index].taskName,
                            style: new TextStyle(
                                fontSize: 22.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          new Text(
                            getDateDifference(
                                widget.taskList[index].taskDeadLine),
                            style: new TextStyle(
                                fontSize: 16.0, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () => edit(widget.taskListBloc,
                              widget.taskList[index], context)),
                      new IconButton(
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () => widget.taskListBloc
                              .deleteTask(widget.taskList[index]))
                    ],
                  )
                ],
              ),
              padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
            ),
            color: Colors.transparent,
          );
        });
  }

  String getDateDifference(String date) {
    final nowDate = DateTime.now();
    final deathLineDate = new DateFormat("yyyy-MM-dd").parse(date);
    getLastTimeInHours(deathLineDate);
    return deathLineDate.difference(nowDate).inDays == 0
        ? "Время вышло"
        : "Oсталось " +
            deathLineDate.difference(nowDate).inDays.toString() +
            " дн. и " +
            getLastTimeInHours(deathLineDate) +
            ":" +
            getLastTimeInMinutes(deathLineDate) +
            ":" +
            getLastTimeInSeconds(deathLineDate) +
            ":" +
            getLastTimeInMilliseconds(deathLineDate).toString();
  }

  String getLastTimeInHours(DateTime deathLineDate) {
    final nowDate = DateTime.now();
    return (deathLineDate.difference(nowDate).inHours % 24).toString().length ==
            1
        ? "0" + (deathLineDate.difference(nowDate).inHours % 24).toString()
        : (deathLineDate.difference(nowDate).inHours % 24).toString();
  }

  String getLastTimeInMinutes(DateTime deathLineDate) {
    final nowDate = DateTime.now();
    return (deathLineDate.difference(nowDate).inMinutes % 60)
                .toString()
                .length ==
            1
        ? "0" + (deathLineDate.difference(nowDate).inMinutes % 60).toString()
        : (deathLineDate.difference(nowDate).inMinutes % 60).toString();
  }

  String getLastTimeInSeconds(DateTime deathLineDate) {
    final nowDate = DateTime.now();
    return (deathLineDate.difference(nowDate).inSeconds % 60)
                .toString()
                .length ==
            1
        ? "0" + (deathLineDate.difference(nowDate).inSeconds % 60).toString()
        : (deathLineDate.difference(nowDate).inSeconds % 60).toString();
  }

  String getLastTimeInMilliseconds(DateTime deathLineDate) {
    final nowDate = DateTime.now();
    return (deathLineDate.difference(nowDate).inMilliseconds % 1000)
                .toString()
                .length ==
            1
        ? "0" +
            (deathLineDate.difference(nowDate).inMilliseconds % 1000).toString()
        : (deathLineDate.difference(nowDate).inMilliseconds % 1000).toString();
  }

  edit(TaskListBloc taskListBloc, ItemTaskNew itemTask, BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new AddTaskView(
                taskListBloc: taskListBloc, isEdit: true, itemTask: itemTask)));
//    Navigator.of(context).pushNamed(AddTaskView.routeName,
//        arguments: TaskArguments(true, itemTask));
  }

  @override
  void initState() {
    super.initState();
    const oneSecond = const Duration(milliseconds: 50);
    new Timer.periodic(oneSecond, (Timer t) => widget.taskListBloc.getTasks());
  }
}
