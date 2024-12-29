import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../Controllers/MainController.dart';
import '../Model/auth.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);
    final AppAuth auth = Provider.of<MainController>(context, listen: false).getAuth;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Profile',
            ),
            Text (auth.signedIn ? 'Signed in' : 'Sign in to view'

              ),
            TextButton(
              // style: ButtonStyle(
              //   foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              // ),
              onPressed: () { goRouter.go('/login');},
              child: Text('Login'),

            ),

          ],

        ),
      ),

    );
  }
}