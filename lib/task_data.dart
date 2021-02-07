import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'tasks.dart';
import 'firebasee/database.dart';

class TaskData extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getCurrentUser() {
    final User user = _auth.currentUser;
    final uid = user.uid;
    return uid;
  }

  void addTask(String newTaskTitle) {
    DatabaseService(uid: getCurrentUser()).updateUserData(newTaskTitle, false);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggle();
    DatabaseService(uid: getCurrentUser()).updateDone(task.name, task.isDone);
    notifyListeners();
  }

  void deleteTask(Task task) {
    DatabaseService(uid: getCurrentUser()).deleteData(task.name);
    notifyListeners();
  }
}
