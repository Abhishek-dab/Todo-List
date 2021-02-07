import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import '../task_data.dart';
import 'showDialog.dart';
import 'package:todo_list/tasks.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Task>>(context) ?? [];

    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskTile(
              brew: brews[index],
              checkboxCallback: (checkboxState) {
                taskData.updateTask(brews[index]);
              },
              longPress: () {
                showAlertDialog(context, taskData, brews[index]);
              },
            );
          },
          itemCount: brews.length,
        );
      },
    );
  }
}
