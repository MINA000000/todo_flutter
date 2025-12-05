  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:todo_app/home_screen.dart';
  import 'package:todo_app/main.dart';
  import 'package:todo_app/providers/tasks_provider.dart';

  class SettingsTab extends StatelessWidget {
    const SettingsTab({super.key});

    @override
    Widget build(BuildContext context) {
      TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
      return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.all(5),
              child: IconButton(
                icon: Icon(Icons.logout, size: 30),
                onPressed: () async {
                  await tasksProvider.logOut();

                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Lol.route,
                    (_) => false,
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
