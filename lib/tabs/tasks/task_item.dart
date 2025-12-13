import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/tabs/tasks/task_details.dart';

class TaskItem extends StatefulWidget {
  TaskItem({super.key, required this.taskModel});
  TaskModel taskModel;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return GestureDetector(
      onLongPress: () {
        Navigator.of(context)..push(
          MaterialPageRoute(
            builder: (context) => TaskDetails(taskModel: widget.taskModel),
          ),
        );
        // print("hello world");
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Slidable(
          key: const ValueKey(0),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),

            dismissible: DismissiblePane(onDismissed: () {}),

            children: [
              SlidableAction(
                onPressed: (_) {
                  FirebaseFunctions.deleteTaskFromFireStore(widget.taskModel.id)
                      .timeout(
                        Duration(microseconds: 100),
                        onTimeout: () {
                          Provider.of<TasksProvider>(
                            context,
                            listen: false,
                          ).getTasks();
                          Fluttertoast.showToast(
                            msg: 'Task Deleted Successfully',
                            backgroundColor: AppTheme.green,
                            fontSize: 16,
                            textColor: AppTheme.white,
                            toastLength: Toast.LENGTH_LONG,
                          );
                        },
                      )
                      .catchError((e) {
                        Fluttertoast.showToast(
                          msg: 'Something went wrong',
                          backgroundColor: AppTheme.red,
                          fontSize: 16,
                          textColor: AppTheme.white,
                          toastLength: Toast.LENGTH_LONG,
                        );
                      });
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: settingsProvider.mode == 'dark'
                  ? AppTheme.blackNavi
                  : AppTheme.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 10),
                      width: 4,
                      height: 62,
                      color: widget.taskModel.isDone
                          ? AppTheme.green
                          : theme.primaryColor,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.taskModel.title,
                          style: widget.taskModel.isDone
                              ? theme.textTheme.bodyLarge?.copyWith(
                                  color: AppTheme.green,
                                )
                              : theme.textTheme.bodyLarge,
                        ),
                        Text(
                          widget.taskModel.description,
                          style: TextStyle(
                            color: settingsProvider.mode == 'dark'
                                ? AppTheme.white
                                : AppTheme.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    widget.taskModel.isDone = !widget.taskModel.isDone;
                    await FirebaseFunctions.changeTask(widget.taskModel);
                    setState(() {});
                  },
                  child: Container(
                    width: 69,
                    height: 34,
                    decoration: BoxDecoration(
                      color: widget.taskModel.isDone
                          ? AppTheme.green
                          : theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.check, color: AppTheme.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
