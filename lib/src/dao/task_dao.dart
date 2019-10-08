import 'package:flutter_todo_2/src/database/database_provider.dart';
import 'package:flutter_todo_2/src/database/models/item_task_new.dart';

class TaskDao{
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> insertTask(ItemTaskNew itemTask) async {
    final db = await dbProvider.database;

    int res = await db.insert(DB_NAME, itemTask.toMap());
    return res;
  }

  Future<List<ItemTaskNew>> getTasks() async {
    final db = await dbProvider.database;

    List<Map> list = await db.rawQuery("Select * from $DB_NAME");
    List<ItemTaskNew> taskList = new List();
    for (int i = 0; i < list.length; i++) {
      var itemTask = ItemTaskNew((b) => b..taskName = list[i]["taskname"]
      ..taskDeadLine = list[i]["taskdeadline"]..id = list[i]["id"]);
      taskList.add(itemTask);
    }
    return taskList;
  }

  Future<int> deleteTask(ItemTaskNew itemTask) async {
    final db = await dbProvider.database;

    int res = await db
        .rawDelete("Delete From $DB_NAME where id = ?", [itemTask.id]);
    return res;
  }

  Future<bool> update(ItemTaskNew itemTask) async {
    final db = await dbProvider.database;

    int res = await db.update(DB_NAME, itemTask.toMap(),
        where: "id = ?", whereArgs: <int>[itemTask.id]);
    return res > 0 ? true : false;
  }
}