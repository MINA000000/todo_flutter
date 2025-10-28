import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getCollectiontasks() =>
      FirebaseFirestore.instance
          .collection('tasks')
          .withConverter<TaskModel>(
            fromFirestore: (snapshot, _) =>
                TaskModel.fromJson(snapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );
  static addTaskToFirestore(TaskModel taskModel) {
    CollectionReference<TaskModel> tasks = getCollectiontasks();
    DocumentReference<TaskModel> doc = tasks.doc();
    taskModel.id = doc.id;
    return doc.set(taskModel);
  }

  static Future<List<TaskModel>> getAllTasks() async {
    CollectionReference<TaskModel> tasksRef = getCollectiontasks();
    QuerySnapshot<TaskModel> querySnapshot = await tasksRef.get();
    List<TaskModel> listTasks = querySnapshot.docs.map((e) => e.data()).toList();
    return listTasks;
  }
}
