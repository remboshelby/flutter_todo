import 'dart:async';

import 'package:flutter_todo_2/src/database/models/item_task.dart';
import 'package:flutter_todo_2/src/database/models/item_task_new.dart';
import 'package:flutter_todo_2/src/repository/task_repository.dart';

class TaskListBloc {
  final _taskRepository = TaskRepository();

  final _taskController = StreamController<List<ItemTaskNew>>.broadcast();

  get tasks => _taskController.stream;

  TaskListBloc() {
    getTasks();
  }

  void getTasks() async {
    _taskController.sink.add(await _taskRepository.getAllTask());
  }

  addTask(ItemTaskNew itemTask) async {
    await _taskRepository.insertTask(itemTask);
    getTasks();
  }

  updateTask(ItemTaskNew itemTask) async {
    await _taskRepository.updateTask(itemTask);
    getTasks();
  }

  deleteTask(ItemTaskNew itemTask) async {
    await _taskRepository.deleteTask(itemTask);
    getTasks();
  }

  dispose() {
    _taskController.close();
  }
}
