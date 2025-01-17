import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Views/components/customButton.dart';
import 'package:task_manager/Views/components/customTextField.dart';
import 'package:task_manager/Views/components/imageButton.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage ({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // Sign in user method
  void signUserIn() async {

    // Start loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center (
            child: CircularProgressIndicator(),
          );
        }
    );

    // Try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Pop loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop loading circle
      Navigator.pop(context);

      // Handle wrong email
      if (e.code == 'invalid-email') {
        showErrorMessage("Cannot find an account with that email");
      }
      // Handle wrong password
      else if (e.code == 'invalid-credential') {
        showErrorMessage("Incorrect Password");
      }
    }
  }

  // Pop up error
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const SizedBox (height: 50),

          // Logo
          Icon(
            Icons.lock,
            size: 100
          ), // Change to actual icon

          const SizedBox (height: 50),

          //   Message
          Text (
            'Welcome back, {NAME}!',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),
          ),

          const SizedBox (height: 25),

          //   Email textfield
          CustomTextField(
            controller: emailController,
            hintText: 'Email',
            obscureText: false,
          ),

          const SizedBox (height: 25),

          CustomTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
          ),

          const SizedBox (height: 4),
          // Forgot password

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.grey[600]),
                )
              ],
            ),
          ),

          const SizedBox (height: 25),



      //   Submit button
          CustomButton(
            onTap: signUserIn,
            text: "Sign In",
          ),

          const SizedBox (height: 25),

      //   Continue with

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Or continue with',
                    style: TextStyle(color: Colors.grey[700])
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                  ),
        ],
            ),

          ),

          const SizedBox (height: 25),
      // Apple / Google

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            //   Google
              ImageButton(imagePath: 'lib/assets/google.png'),

            const SizedBox(width: 10),
            //   Apple
              ImageButton(imagePath: 'lib/assets/apple.png'),
            ],
          ),



          const SizedBox(height: 25),

      //   Register

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Not a member?',
                  style: TextStyle(
                    color: Colors.grey[400],
                  )
              ),

              const SizedBox(width: 4),

              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                    'Register now',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                    )
                ),
              )
            ],
          )
      ]
    )
    )
    )
      )
    );
  }
}