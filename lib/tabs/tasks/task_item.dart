import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

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
                Text("Play basket ball",style: theme.textTheme.bodyLarge,),
                Text("description about basket ball here"),
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