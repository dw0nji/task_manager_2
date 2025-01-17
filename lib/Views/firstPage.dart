import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class firstPage extends StatelessWidget {
  firstPage ({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // DO NOT DELETE
  // This page will become settings

  // Sign user out
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: signOut, icon: Icon(Icons.logout),
        )]),
      body: Center(child: Text("Logged in as" + user.email!)),
    );
  }
}