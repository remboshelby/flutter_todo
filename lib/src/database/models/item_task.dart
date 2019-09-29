class ItemTask {
  int id;
  String _taskName;
  String _taskDeadLine;

  ItemTask(this._taskName, this._taskDeadLine);

  ItemTask.map(dynamic obj) {
    this._taskName = obj["taskname"];
    this._taskDeadLine = obj["taskdeadline"];
  }

  String get taskName => _taskName;

  String get taskDeadLine => _taskDeadLine;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["taskname"] = _taskName;
    map["taskdeadline"] = _taskDeadLine;
    return map;
  }

  void setTaskId(int id) {
    this.id = id;
  }
}
