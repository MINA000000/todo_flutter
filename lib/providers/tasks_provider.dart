import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();
  UserModel? currentUser ;
  Future<void> getTasks() async {
    tasks = await FirebaseFunctions.getAllTasks();
    tasks.sort((a, b) {
      return (b.date.toString().compareTo(a.date.toString()));
    });
    tasks = tasks.where((task) {
      if (task.date.day == selectedDate.day &&
          task.date.year == selectedDate.year &&
          task.date.month == selectedDate.month) {
        return true;
      }
      return false;
    }).toList();
    notifyListeners();
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }
  Future<void> logOut() async {
  await FirebaseAuth.instance.signOut();
  tasks = [];
  currentUser = null;
  notifyListeners();
}
}
