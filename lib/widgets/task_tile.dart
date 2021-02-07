import 'package:flutter/material.dart';
import 'package:todo_list/tasks.dart';

class TaskTile extends StatelessWidget {
  final Function checkboxCallback;
  final Function longPress;
  final Task brew;
  TaskTile({this.brew, this.checkboxCallback, this.longPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPress,
      title: Text(
        brew.name,
        style: TextStyle(
            decoration: brew.isDone ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.blueAccent,
        value: brew.isDone,
        onChanged: checkboxCallback,
      ),
    );
  }
}
