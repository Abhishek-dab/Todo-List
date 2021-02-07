import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/tasks.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('taskA');

  Future<void> updateUserData(String task, bool done) async {
    return await brewCollection.doc(uid).collection('taskB').add({
      "task": task,
      "done": done,
      "time": DateTime.now().microsecondsSinceEpoch,
    }).catchError((e) {
      print(e.toString());
    });
  }

  updateDone(String task, bool done) async {
    final QuerySnapshot searchedUserId = await brewCollection
        .doc(uid)
        .collection('taskB')
        .where('task', isEqualTo: task)
        .limit(1)
        .get();

    DocumentSnapshot document = searchedUserId.docs.first;
    final userDocId = document.id;

    brewCollection
        .doc(uid)
        .collection('taskB')
        .doc(userDocId)
        .update({'done': done});
  }

  deleteData(String task) async {
    final QuerySnapshot searchedUserId = await brewCollection
        .doc(uid)
        .collection('taskB')
        .where('task', isEqualTo: task)
        .limit(1)
        .get();

    DocumentSnapshot document = searchedUserId.docs.first;
    final userDocId = document.id;

    brewCollection.doc(uid).collection('taskB').doc(userDocId).delete();
  }

  List<Task> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Task(
        name: doc.data()['task'] ?? '',
        isDone: doc.data()['done'] ?? false,
      );
    }).toList();
  }

  Stream<List<Task>> get brews {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser;
    final uidd = user.uid;
    return brewCollection
        .doc(uidd)
        .collection("taskB")
        .orderBy("time", descending: true)
        .snapshots()
        .map(_brewListFromSnapshot);
  }
}
