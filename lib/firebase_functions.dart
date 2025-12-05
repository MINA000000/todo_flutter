import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getCollectiontasks() =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .withConverter<TaskModel>(
            fromFirestore: (snapshot, _) =>
                TaskModel.fromJson(snapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );
  static CollectionReference<UserModel> getCollectionUsers() =>
      FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (userModel, options) => userModel.toJson(),
          );
  static Future<void> addTaskToFirestore(TaskModel taskModel) {
    CollectionReference<TaskModel> tasks = getCollectiontasks();
    DocumentReference<TaskModel> doc = tasks.doc();
    taskModel.id = doc.id;
    return doc.set(taskModel);
  }

  static Future<List<TaskModel>> getAllTasks() async {
    CollectionReference<TaskModel> tasksRef = getCollectiontasks();
    QuerySnapshot<TaskModel> querySnapshot = await tasksRef.get();
    List<TaskModel> listTasks = querySnapshot.docs
        .map((e) => e.data())
        .toList();
    return listTasks;
  }

  static Future<void> deleteTaskFromFireStore(String TaskId) {
    CollectionReference taskCollection = getCollectiontasks();
    return taskCollection.doc(TaskId).delete();
  }

  static Future<UserModel> register({
    required String email,
    required String name,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    CollectionReference<UserModel> usersCollection = getCollectionUsers();
    UserModel userModel = UserModel(
      email: email,
      id: userCredential.user!.uid,
      name: name,
    );
    usersCollection.doc(userCredential.user!.uid).set(userModel);
    return userModel;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    CollectionReference<UserModel> usersCollection = getCollectionUsers();
    DocumentSnapshot<UserModel> documentSnapshot = await usersCollection
        .doc(userCredential.user!.uid)
        .get();
    return documentSnapshot.data()!;
  }
}
