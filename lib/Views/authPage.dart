import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/Views/firstPage.dart';
import 'package:task_manager/Views/loginOrRegisterPage.dart';
import 'package:task_manager/Views/loginPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) { // If user is logged in
            return firstPage(); // Fix
          } else {
            return LoginOrRegisterPage();
          }
        }
      )
    );
  }
}