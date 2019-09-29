import 'dart:async';

import 'package:flutter_todo_2/src/database/models/item_task.dart';
import 'package:flutter_todo_2/src/repository/task_repository.dart';

class TaskListBloc {
  final _taskRepository = TaskRepository();

  final _taskController = StreamController<List<ItemTask>>.broadcast();

  get tasks => _taskController.stream;

  TaskListBloc() {
    getTasks();
  }

  void getTasks() async {
    _taskController.sink.add(await _taskRepository.getAllTask());
  }

  addTask(ItemTask itemTask) async {
    await _taskRepository.insertTask(itemTask);
    getTasks();
  }

  updateTask(ItemTask itemTask) async {
    await _taskRepository.updateTask(itemTask);
    getTasks();
  }

  deleteTask(ItemTask itemTask) async {
    await _taskRepository.deleteTask(itemTask);
    getTasks();
  }

  dispose() {
    _taskController.close();
  }
}
