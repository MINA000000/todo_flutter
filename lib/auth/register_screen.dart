import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/widgets/default_elevated_button.dart';
import 'package:todo_app/widgets/default_text_form.dart';

class RegisterScreen extends StatelessWidget {
  static const String route = '/Register-screen';
  RegisterScreen({super.key});

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Regiser',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextForm(
                hint: 'Enter your name',
                controller: nameController,
                validator: (name) {
                  if (name == null || name.trim().isEmpty) {
                    return 'name should not be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              DefaultTextForm(
                hint: 'Enter your password again',
                controller: confirmPasswordController,
                validator: (password) {
                  if (password == null ||
                      password.trim().compareTo(
                            passwordController.text.trim(),
                          ) !=
                          0) {
                    return 'Password and confirm password should be the same';
                  }
                  return null;
                },
                isPassword: true,
              ),
              SizedBox(height: 32),
              DefaultElevatedButton(
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    register()
                        .then((userModel) {
                          if (!context.mounted) return;
                          Provider.of<TasksProvider>(
                            context,
                            listen: false,
                          ).currentUser = userModel;
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(HomeScreen.route);
                        })
                        .catchError((error) {
                          if (error is FirebaseAuthException) {
                            Fluttertoast.showToast(
                              msg: error.code,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                            );
                          }
                        });
                  }
                },
                text: 'Register',
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(LoginScreen.route);
                },
                child: Text(
                  'Have an account?',
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

  Future<UserModel> register() {
    return FirebaseFunctions.register(
      email: emailController.text,
      name: nameController.text,
      password: passwordController.text,
    );
  }
}
