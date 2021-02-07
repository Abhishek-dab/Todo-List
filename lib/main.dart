import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/firebasee/auth.dart';
import 'package:todo_list/task_data.dart';
import 'wrapper.dart';
import 'user.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: StreamProvider<Users>.value(
        value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
        ),
      ),
    );
  }
}
