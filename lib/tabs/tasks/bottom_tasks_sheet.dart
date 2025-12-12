import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/l10n/app_localizations.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/widgets/default_elevated_button.dart';
import 'package:todo_app/widgets/default_text_form.dart';

class BottomTasksSheet extends StatefulWidget {
  const BottomTasksSheet({super.key});

  @override
  State<BottomTasksSheet> createState() => _BottomTasksSheetState();
}

class _BottomTasksSheetState extends State<BottomTasksSheet> {
  TextEditingController titleController = TextEditingController(),
      descriptionController = TextEditingController();

  DateFormat dateformat = DateFormat('dd/MM/yyyy');
  // DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * .4,
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.addNewTask,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppTheme.black),
              ),
              DefaultTextForm(
                hint: AppLocalizations.of(context)!.enterTitle,
                controller: titleController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Title Should not be empty";
                  }
                  return null;
                },
              ),
              DefaultTextForm(
                hint: AppLocalizations.of(context)!.enterDescription,
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "description Should not be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.selectDate,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppTheme.black),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () async {
                  tasksProvider.selectedDate =
                      await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                        currentDate: tasksProvider.selectedDate,
                        initialDate: tasksProvider.selectedDate,
                      ) ??
                      tasksProvider.selectedDate;
                  setState(() {});
                },
                child: Text(
                  dateformat.format(tasksProvider.selectedDate),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 15),
                ),
              ),
              SizedBox(height: 10),
              DefaultElevatedButton(
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    addTask(tasksProvider.selectedDate);
                  } else {
                    print("catch error here baby");
                  }
                },
                text: AppLocalizations.of(context)!.add,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTask(DateTime datetime) {
    TaskModel taskModel = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      date: datetime,
    );
    FirebaseFunctions.addTaskToFirestore(taskModel)
        .then((value) {
          Navigator.pop(context);
          Provider.of<TasksProvider>(context, listen: false).getTasks();
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.taskAddedSuccessfully,
            backgroundColor: Colors.green,
            fontSize: 16,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
          );
        })
        .catchError((e) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.somethingWentWrong,
            backgroundColor: Colors.red,
            fontSize: 16,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
          );
        });
  }
}
