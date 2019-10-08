import 'package:flutter_todo_2/src/dao/task_dao.dart';
import 'package:flutter_todo_2/src/database/models/item_task.dart';
import 'package:flutter_todo_2/src/database/models/item_task_new.dart';

class TaskRepository {
  final taskDao = TaskDao();

  Future getAllTask() => taskDao.getTasks();

  Future insertTask(ItemTaskNew itemTask) => taskDao.insertTask(itemTask);

  Future updateTask(ItemTaskNew itemTask) => taskDao.update(itemTask);

  Future deleteTask(ItemTaskNew itemTask) => taskDao.deleteTask(itemTask);
}
