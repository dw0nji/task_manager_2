import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'auth.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title, required this.auth});

  final String title;
  final AppAuth auth;


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final AppAuth auth;

  @override
  void initState() {
    super.initState();
    auth = widget.auth; // Initialize the auth object here
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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