import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_todo_2/src/bloc/task_list_bloc.dart';
import 'package:flutter_todo_2/src/database/models/item_task.dart';
import 'package:flutter_todo_2/src/database/models/item_task_new.dart';
import 'package:intl/intl.dart';

class AddTaskView extends StatefulWidget {
  static const routeName = '/addTask';

  final bool isEdit;
  final ItemTaskNew itemTask;
  final TaskListBloc taskListBloc;

  const AddTaskView({
    Key key,
    @required this.taskListBloc,
    @required this.isEdit,
    @required this.itemTask,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _AddTaskView();
  }
}

class _AddTaskView extends State<AddTaskView> {
  final teTaskName = TextEditingController();
  String task_date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  TaskListBloc taskListBloc;

  bool isEdit;
  ItemTaskNew itemTask;


  @override
  void initState() {
    taskListBloc = widget.taskListBloc;
    isEdit = widget.isEdit;
    if (widget.itemTask != null) {
      this.itemTask = widget.itemTask;
      task_date = widget.itemTask.taskDeadLine;
      teTaskName.text = widget.itemTask.taskName;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            isEdit ? "Изменить цель" : "Создать цель",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: new Container(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getTextField("Название твоей цели", teTaskName),
              getDateTimePicker(),
              new GestureDetector(
                onTap: () {
                  addRecord(isEdit);
//                _myHomePageState.displayRecord();
                  Navigator.of(context).pop();
                },
                child: new Container(
                  margin: EdgeInsets.all(10.0),
                  child: getAppBorderButton(isEdit ? "Изменить" : "Создать"),
                ),
              )
            ],
          ),
        ));
  }

  Future addRecord(bool isEdit) async {
    var itemTask = ItemTaskNew((b) => b..taskDeadLine = task_date.. taskName = teTaskName.text);
    if (isEdit) {
//      itemTask.setTaskId(this.itemTask.id);
      var itemTask = ItemTaskNew((b) => b..taskDeadLine = task_date.. taskName = teTaskName.text
      ..id = this.itemTask.id);
      await taskListBloc.updateTask(itemTask);
    } else {
      await taskListBloc.addTask(itemTask);
    }
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var textField = new Padding(
      padding: const EdgeInsets.all(10.0),
      child: new TextFormField(
        controller: inputBoxController,
        decoration: new InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
          ),
          hintText: inputBoxName,
          prefixText: ' ',
        ),
      ),
    );
    return textField;
  }

  Widget getAppBorderButton(String buttonLabel) {
    var btn = new Container(
      padding: EdgeInsets.all(14.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: new BorderRadius.all(const Radius.circular(6.0))),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return btn;
  }

  Widget getDateTimePicker() {
    return RaisedButton(
      elevation: 0,
      padding: const EdgeInsets.all(10.0),
      onPressed: () {
        DatePicker.showDatePicker(context,
            theme: DatePickerTheme(
              containerHeight: 210.0,
            ),
            showTitleActions: true,
            minTime: DateTime.now(),
            maxTime: DateTime(2025, 12, 31), onConfirm: (date) {
          task_date = '${date.year}-${date.month}-${date.day}';
          setState(() {});
        }, currentTime: DateTime.now(), locale: LocaleType.ru);
      },
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.date_range,
                          size: 18, color: Colors.blueAccent),
                      Text(
                        " $task_date",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Text(
              " Изменить",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ),
      color: Colors.transparent,
    );
  }
}

class TaskArguments {
  final bool isEdit;
  final ItemTaskNew itemTask;

  TaskArguments(this.isEdit, this.itemTask);
}
