import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/tabs/settings/settings_tab.dart';
import 'package:todo_app/tabs/tasks/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String route = '/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs= [
    TasksTab(),
    SettingsTab()
  ];
  int currentIndx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: AppTheme.white,
        shape: const CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: currentIndx,
          onTap: (value) {
            setState(() {
              currentIndx = value;
            });
          },
          items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            ),
        ]),
      ),
      body: tabs[currentIndx],
      floatingActionButton: Container(
        width: 65,
        height: 65,
        child: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.add,),    
        ),
      ),
    
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}