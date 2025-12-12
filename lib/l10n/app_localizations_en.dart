// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get todoTitle => 'ToDo App';

  @override
  String get language => 'Language';

  @override
  String get mode => 'Mode';

  @override
  String get addNewTask => 'Add New Task';

  @override
  String get enterTitle => 'Enter title';

  @override
  String get enterDescription => 'Enter Description';

  @override
  String get selectDate => 'Select Date';

  @override
  String get taskAddedSuccessfully => 'Task added successfully';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get add => 'Add';
}
