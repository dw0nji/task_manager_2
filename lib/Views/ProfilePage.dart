import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Profile",
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: user != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile image with rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset("lib/assets/banner.png")
            ),
            SizedBox(height: 20),
            Text('UID: ${user.uid}'),
            Text('Email: ${user.email ?? 'No email'}'),
            Text('Display Name: ${user.displayName ?? 'No display name'}'),
          ],
        )
            : Text('No user signed in'),
      ),
    );
  }
}