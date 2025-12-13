import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/auth/register_screen.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/l10n/app_localizations.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/providers/tasks_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TasksProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ],

      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsProvider settingsProvider = Provider.of<SettingsProvider>(
      context,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Lol(),
      routes: {
        HomeScreen.route: (_) => HomeScreen(),
        LoginScreen.route: (_) => LoginScreen(),
        RegisterScreen.route: (_) => RegisterScreen(),
        Lol.route: (_) => Lol(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsProvider.mode == 'light'
          ? ThemeMode.light
          : ThemeMode.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingsProvider.lan) ,
    );
  }
}

class Lol extends StatelessWidget {
  const Lol({super.key});
  static final String route = '/lol';
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null
        ? HomeScreen()
        : LoginScreen();
  }
}
