import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';

class DefaultElevatedButton extends StatelessWidget {
  DefaultElevatedButton({super.key, required this.onPress, required this.text});
  VoidCallback onPress;
  String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primary,
        fixedSize: Size(255, 52),
      ),
      onPressed: onPress,
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: AppTheme.white),
      ),
    );
  }
}
