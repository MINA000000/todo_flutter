// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get todoTitle => 'تطبيق المهام';

  @override
  String get language => 'اللغة';

  @override
  String get mode => 'الوضع';

  @override
  String get addNewTask => 'اضف مهمة جديدة';

  @override
  String get enterTitle => 'ادخل العنوان';

  @override
  String get enterDescription => 'ادخل التفاصيل';

  @override
  String get selectDate => 'اختر التاريخ';

  @override
  String get taskAddedSuccessfully => 'تم اضافة المهمة بنجاح';

  @override
  String get somethingWentWrong => 'حدث خطأ ما';

  @override
  String get add => 'اضف';
}
