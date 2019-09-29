import 'package:flutter_todo_2/src/dao/task_dao.dart';
import 'package:flutter_todo_2/src/database/models/item_task.dart';

class TaskRepository {
  final taskDao = TaskDao();

  Future getAllTask() => taskDao.getTasks();

  Future insertTask(ItemTask itemTask) => taskDao.insertTask(itemTask);

  Future updateTask(ItemTask itemTask) => taskDao.update(itemTask);

  Future deleteTask(ItemTask itemTask) => taskDao.deleteTask(itemTask);
}
