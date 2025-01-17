import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Views/components/customButton.dart';
import 'package:task_manager/Views/components/customTextField.dart';
import 'package:task_manager/Views/components/imageButton.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage ({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  // Text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Sign up user method
  void signUserUp() async {

    // Start loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center (
            child: CircularProgressIndicator(),
          );
        }
    );

    // Try creating the user
    try {
      // Check if password == confirmed password
      if (passwordController == confirmPasswordController) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // Pop loading circle
        Navigator.pop(context);
      } else {
        showErrorMessage("Password's don't match");
      }

    } on FirebaseAuthException catch (e) {
      // Pop loading circle
      Navigator.pop(context);

      // Handle wrong email
      if (e.code == 'invalid-email') {
        showErrorMessage("Account already exists");
      }
      // Handle wrong password
      else if (e.code == 'invalid-credential') {
        showErrorMessage("Invalid Password");
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
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          const SizedBox (height: 50),

                          Image.asset(
                            'lib/assets/logo.png',
                            width: 100,
                            height: 100,
                          ),

                          const SizedBox (height: 25),

                          //   Message
                          Text (
                            'The Good Calendar',
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox (height: 25),

                          //   Email textfield
                          CustomTextField(
                            controller: emailController,
                            hintText: 'Email',
                            obscureText: false,
                          ),

                          const SizedBox (height: 15),

                          CustomTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: true,
                          ),

                          const SizedBox (height: 15),

                          CustomTextField(
                            controller: confirmPasswordController,
                            hintText: 'Confirm Password',
                            obscureText: true,
                          ),

                          const SizedBox (height: 25),

                          //   Submit button
                          CustomButton(
                            onTap: signUserUp,
                            text: "Continue",
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
                                  'Already have an account?',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  )
                              ),

                              const SizedBox(width: 4),

                              GestureDetector(
                                onTap: widget.onTap,
                                child: const Text(
                                    'Login now',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 25),
                        ]
                    )
                )
            )
        )
    );
  }
}