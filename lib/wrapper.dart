import 'package:flutter/material.dart';
import 'package:todo_list/Screens/task_screen.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/user.dart';
import 'package:todo_list/firebasee/authentication.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return TaskScreen();
    }
  }
}
