import 'package:flutter/material.dart';
import 'package:flutter_todo_2/src/bloc/task_list_bloc.dart';
import 'package:flutter_todo_2/src/list_screen.dart';
import 'package:flutter_todo_2/src/ui/add_task_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var taskListBloc = new TaskListBloc();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => new ListScreen(taskListBloc),
      },
      onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name == AddTaskView.routeName) {
      final TaskArguments args = settings.arguments;

      return _buildRoute(
          settings,
          new AddTaskView(
            taskListBloc: taskListBloc,
            isEdit: args.isEdit,
            itemTask: args.itemTask,
          ));
    }
    return null;
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(builder: (ctx) => builder, settings: settings);
  }
}
