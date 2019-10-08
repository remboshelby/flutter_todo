library item_task_new;

import 'package:built_value/built_value.dart';

part 'item_task_new.g.dart';

abstract class ItemTaskNew implements Built<ItemTaskNew, ItemTaskNewBuilder>{
  @nullable
  int get id;
  @nullable
  String get taskName;
  @nullable
  String get taskDeadLine;

  ItemTaskNew._();

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["taskname"] = taskName;
    map["taskdeadline"] = taskDeadLine;
    return map;
  }

  factory ItemTaskNew([updates(ItemTaskNewBuilder b)]) = _$ItemTaskNew;
}