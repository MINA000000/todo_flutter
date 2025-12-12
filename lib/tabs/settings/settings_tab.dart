import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/l10n/app_localizations.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/providers/tasks_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        actions: [
          Padding(
            padding: EdgeInsets.all(5),
            child: IconButton(
              icon: Icon(Icons.logout, size: 30, color: AppTheme.white),
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
      body: Column(
        children: [
          Container(
            color: AppTheme.backgroundLight,
            // height: height * .19,
            child: Stack(
              children: [
                Container(
                  color: AppTheme.primary,
                  // color: Colors.transparent,
                  height: height * 0.1,
                ),
                PositionedDirectional(
                  start: 15,
                  child: SafeArea(
                    child: Text(
                      AppLocalizations.of(context)!.todoTitle,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsetsDirectional.only(start:20 ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(AppLocalizations.of(context)!.language, style: TextStyle(fontSize: 20)),
            ),
          ),
          SizedBox(height: 15),
          Container(
            color: AppTheme.white,
            child: DropdownMenu(
              width: MediaQuery.of(context).size.width * 0.8,
              initialSelection: settingsProvider.lan,
              onSelected: (value) {
                print(value);
                settingsProvider.changeLanguage(value!);
              },
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 'en', label: 'English'),
                DropdownMenuEntry(value: 'ar', label: 'Arabic'),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsetsDirectional.only(start:20 ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(AppLocalizations.of(context)!.mode, style: TextStyle(fontSize: 20)),
            ),
          ),

          SizedBox(height: 15),
          Container(
            color: AppTheme.white,
            child: DropdownMenu(
              width: MediaQuery.of(context).size.width * 0.8,
              initialSelection: settingsProvider.mode,
              onSelected: (value) {
                settingsProvider.changeMode(value!);
              },
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 'dark', label: 'Dark'),
                DropdownMenuEntry(value: 'light', label: 'Light'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
