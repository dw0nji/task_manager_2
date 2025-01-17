import 'package:flutter/material.dart';
import 'package:task_manager/Views/registerPage.dart';
import 'loginPage.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage ({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
//   Initially show login page
  bool showLoginPage = true;

//   Toggle between register and login page
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePage);
    } else {
      return RegisterPage(onTap: togglePage);
    }
  }
}