import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/widgets/default_elevated_button.dart';
import 'package:todo_app/widgets/default_text_form.dart';

class TaskDetails extends StatefulWidget {
  TaskModel taskModel;
  TaskDetails({super.key, required this.taskModel});
  static final route = '/task_details';

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late TextEditingController titleController = TextEditingController(
        text: widget.taskModel.title,
      ),
      descriptionController = TextEditingController(
        text: widget.taskModel.description,
      );

  DateFormat dateformat = DateFormat('dd/MM/yyyy');

  // DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  late DateTime selectedDate = widget.taskModel.date;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(
          color: settingsProvider.mode == 'light'
              ? AppTheme.white
              : AppTheme.blackNavi,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: settingsProvider.mode == 'light'
                  ? AppTheme.backgroundLight
                  : AppTheme.backgroundDark,
              // height: height * .19,
              child: Stack(
                children: [
                  Container(
                    color: AppTheme.primary,
                    // color: Colors.transparent,
                    height: height * 0.15,
                  ),
                  PositionedDirectional(
                    start: 15,
                    child: SafeArea(
                      child: Text(
                        "To Do List",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: settingsProvider.mode == 'light'
                              ? AppTheme.white
                              : AppTheme.blackNavi,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                        color: settingsProvider.mode == 'light'
                            ? AppTheme.white
                            : AppTheme.blackNavi,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Edit',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: settingsProvider.mode == 'light'
                                          ? AppTheme.blackNavi
                                          : AppTheme.white,
                                    ),
                              ),
                              SizedBox(height: 15),
                              DefaultTextForm(
                                hint: 'Enter your title',
                                controller: titleController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Title Should not be empty";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              DefaultTextForm(
                                hint: 'Enter your description',
                                controller: descriptionController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "description Should not be empty";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Select Date',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: settingsProvider.mode == 'light'
                                          ? AppTheme.blackNavi
                                          : AppTheme.white,
                                    ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () async {
                                  selectedDate =
                                      await showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now().add(
                                          Duration(days: 365),
                                        ),
                                        currentDate: selectedDate,
                                        initialDate: DateTime.now(),
                                      ) ??
                                      selectedDate;
                                  setState(() {});
                                },
                                child: Text(
                                  dateformat.format(selectedDate),
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontSize: 15,
                                        color: settingsProvider.mode == 'light'
                                            ? AppTheme.blackNavi
                                            : AppTheme.white,
                                      ),
                                ),
                              ),
                              SizedBox(height: 30),
                              DefaultElevatedButton(
                                onPress: () async {
                                  if (formKey.currentState!.validate()) {
                                    widget.taskModel.date = selectedDate;
                                    widget.taskModel.title =
                                        titleController.text;
                                    widget.taskModel.description =
                                        descriptionController.text;
                                    await FirebaseFunctions.changeTask(
                                      widget.taskModel,
                                    );
                                    await tasksProvider.getTasks();
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  } else {
                                    print("catch error here baby");
                                  }
                                },
                                text: 'Edit',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
