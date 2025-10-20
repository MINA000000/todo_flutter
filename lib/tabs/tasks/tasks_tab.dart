import 'package:flutter/material.dart';
import 'package:todo_app/tabs/tasks/task_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
    itemBuilder: (_, index) {
      return TaskItem();
    },
    itemCount: 5,
    );
  }
}