import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widgets/default_elevated_button.dart';
import 'package:todo_app/widgets/text_form.dart';

class BottomTasksSheet extends StatefulWidget {
  BottomTasksSheet({super.key});

  @override
  State<BottomTasksSheet> createState() => _BottomTasksSheetState();
}

class _BottomTasksSheetState extends State<BottomTasksSheet> {
  TextEditingController titleController = TextEditingController(),
      descriptionController = TextEditingController();

  DateFormat dateformat = DateFormat('dd/MM/yyyy');

  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * .4,
      width: double.infinity,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              'Add new Task',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppTheme.black),
            ),
            TextForm(
              hint: 'Enter your title',
              controller: titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Title Should not be empty";
                }
                return null;
              },
            ),
            TextForm(
              hint: 'Enter your description',
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
              'Select Date',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppTheme.black),
            ),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () async {
                selectedDate =
                    await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                      currentDate: DateTime.now(),
                      initialDate: selectedDate,
                    ) ??
                    selectedDate;
                setState(() {});
              },
              child: Text(
                dateformat.format(selectedDate),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontSize: 15),
              ),
            ),
            SizedBox(height: 10),
            DefaultElevatedButton(
              onPress: () {
                if (formKey.currentState!.validate()) {
                  addTask();
                  Navigator.pop(context);
                } else {
                  print("catch error here baby");
                }
                
              },
              text: 'Add',
            ),
          ],
        ),
      ),
    );
  }

  void addTask() {
    TaskModel taskModel = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      date: DateTime.now(),
    );
    FirebaseFunctions.addTaskToFirestore(taskModel);
  }
}
