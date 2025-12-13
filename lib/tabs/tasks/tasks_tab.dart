import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/l10n/app_localizations.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/tabs/tasks/task_item.dart';
import 'package:todo_app/providers/tasks_provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  bool shouldGetTasks = true;
  @override
  Widget build(BuildContext context) {
    // print(AppLocalizations.of(context)!.todoTitle);
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    if (shouldGetTasks) {
      tasksProvider.getTasks();
      shouldGetTasks = false;
    }
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          color: settingsProvider.mode == 'light'
              ? AppTheme.backgroundLight
              : AppTheme.blackNavi,
          height: height * .19,
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
                    AppLocalizations.of(context)!.todoTitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: settingsProvider.mode == 'light'
                          ? AppTheme.white
                          : AppTheme.blackNavi,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: EasyInfiniteDateTimeLine(
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  focusDate: tasksProvider.selectedDate,
                  onDateChange: (date) {
                    tasksProvider.changeSelectedDate(date);
                    tasksProvider.getTasks();
                  },
                  lastDate: DateTime.now().add(Duration(days: 365)),
                  showTimelineHeader: false,
                  dayProps: EasyDayProps(
                    width: 58,
                    height: 79,
                    dayStructure: DayStructure.dayStrDayNum,
                    activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: settingsProvider.mode == 'light'
                            ? AppTheme.white
                            : AppTheme.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      dayNumStyle: Theme.of(context).textTheme.bodyLarge,
                      dayStrStyle: Theme.of(context).textTheme.bodyLarge,
                      // borderRadius: 4,
                    ),
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: settingsProvider.mode == 'light'
                            ? AppTheme.white
                            : AppTheme.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      dayNumStyle: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(
                            color: settingsProvider.mode == 'light'
                                ? AppTheme.black
                                : AppTheme.white,
                            fontSize: 15,
                          ),
                      dayStrStyle: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(
                            color: settingsProvider.mode == 'light'
                                ? AppTheme.black
                                : AppTheme.white,
                            fontSize: 15,
                          ),
                    ),
                    todayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: settingsProvider.mode == 'light'
                            ? AppTheme.white
                            : AppTheme.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      dayNumStyle: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(
                            color: settingsProvider.mode == 'light'
                                ? AppTheme.black
                                : AppTheme.white,
                            fontSize: 15,
                          ),
                      dayStrStyle: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(
                            color: settingsProvider.mode == 'light'
                                ? AppTheme.black
                                : AppTheme.white,
                            fontSize: 15,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (_, index) {
              return TaskItem(taskModel: tasksProvider.tasks[index]);
            },
            itemCount: tasksProvider.tasks.length,
          ),
        ),
      ],
    );
  }
}
