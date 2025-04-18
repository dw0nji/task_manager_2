import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Views/components/dayStats.dart';

import '../Controllers/MainController.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final controller = Provider.of<MainController>(context);

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
            DayStatWidget(taskCounts: controller.getTaskStats(0)),

            GestureDetector(
              onTap: () async {
                FirebaseAuth.instance.signOut();
              },
              child: Text(
                "Signout",
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            )
          ],
        )
            : Text('No user signed in'),
      ),
    );
  }
}