import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/models/task_model.dart';

class TaskItem extends StatelessWidget {
   TaskItem({super.key,required this.taskModel});
  TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppTheme.white,
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
                color: theme.primaryColor,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(taskModel.title,style: theme.textTheme.bodyLarge,),
                Text(taskModel.description),
              ],
              )
             ],
           ),
          Container(
            width: 69,
            height: 34,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(Icons.check,color: AppTheme.white,),
          )
        ],
      ),
    );
  }
}