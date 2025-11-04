import 'package:flutter/material.dart';
import 'package:todo_app/auth/register_screen.dart';
import 'package:todo_app/widgets/default_elevated_button.dart';
import 'package:todo_app/widgets/default_text_form.dart';

class LoginScreen extends StatelessWidget {
  static const String route = '/login-screen';
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextForm(
                hint: 'Enter your email',
                controller: emailController,
                validator: (email) {
                  if (email == null || email.trim().length < 5) {
                    return 'Email should contain at least 5 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DefaultTextForm(
                hint: 'Enter your password',
                controller: passwordController,
                validator: (password) {
                  if (password == null || password.trim().length < 6) {
                    return 'Password should contain at least 6 characters';
                  }
                  return null;
                },
                isPassword: true,
              ),
              SizedBox(height: 32),
              DefaultElevatedButton(
                onPress: () {
                  if (formKey.currentState!.validate()) {}
                },
                text: 'Login',
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(RegisterScreen.route);
                },
                child: Text(
                  'Don\'t have an account?',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
