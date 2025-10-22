import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/tabs/tasks/task_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          color: AppTheme.backgroundLight,
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
                    "Todo App",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.white,
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
                  focusDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                  showTimelineHeader: false,
                  dayProps: EasyDayProps(
                    width: 58,
                    height: 79,
                    dayStructure: DayStructure.dayStrDayNum,
                    activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      dayNumStyle: Theme.of(context).textTheme.bodyLarge,
                      dayStrStyle: Theme.of(context).textTheme.bodyLarge,
                      // borderRadius: 4,
                    ),
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      dayNumStyle: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(color: AppTheme.black, fontSize: 15),
                      dayStrStyle: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(color: AppTheme.black, fontSize: 15),
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
              return TaskItem();
            },
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
