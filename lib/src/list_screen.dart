import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_2/src/database/models/item_task_new.dart';
import 'package:flutter_todo_2/src/ui/add_task_view.dart';
import 'package:flutter_todo_2/src/ui/task_list.dart';

import 'bloc/task_list_bloc.dart';
import 'database/models/item_task.dart';

final routeName = '/list';

class ListScreen extends StatefulWidget {
  final TaskListBloc taskListBloc;

  ListScreen(this.taskListBloc);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: _buildTitle(context),
          actions: _buildActions(),
        ),
        body: StreamBuilder(
          stream: widget.taskListBloc.tasks,
          builder: (context, AsyncSnapshot<List<ItemTaskNew>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.length != 0
                  ? new TaskList(widget.taskListBloc, snapshot.data)
                  : noTaskMessageWidget();
            } else {
              return loadingData();
            }
            ;
          },
        ),
      ),
    );
  }

  Widget loadingData() {
    widget.taskListBloc.tasks;
    return Center(
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text("Загрузка...",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
            ],
          ),
        ),
      ),
    );
  }

  Widget noTaskMessageWidget() {
    return Container(
      child: Center(
        child: Text(
          "Тут пусто :C",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return new InkWell(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Мои цели',
              style: new TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      new FlatButton(
          textColor: Colors.lightBlue,
          child: Text("Добавить", style: TextStyle(fontSize: 18),),
          shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          onPressed: _openAddUserDialog)
    ];
  }

  Future _openAddUserDialog() async {
    Navigator.pushNamed(context, AddTaskView.routeName,
        arguments: TaskArguments(false, null));
  }
}
