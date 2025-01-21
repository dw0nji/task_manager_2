
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_manager/Views/HomePage.dart';
import 'package:task_manager/Views/authPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Controllers/DBController.dart';
import 'package:task_manager/Views/scaffold.dart';

import 'Controllers/MainController.dart';
import 'Views/HomePage.dart';
import 'Views/ProfilePage.dart';
import 'Views/widgets/fade_transition_page.dart';
import 'Views/loginPage.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final appShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'app shell');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => MainController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ProfilePage get myProfilePage => ProfilePage();
  AuthPage get authPage => AuthPage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        debugLogDiagnostics: true,
        initialLocation: '/auth', // change this to change the initial route
        routes: [
          ShellRoute(
            navigatorKey: appShellNavigatorKey,
            builder: (context, state, child) { //TODO: This isn't a good use shellroute
              return child;
              //   TaskManagerScaffold(
              //   selectedIndex: switch (state.uri.path) {
              //     var p when p.startsWith('/home') => 0,
              //     var p when p.startsWith('/profile') => 1,
              //     _ => 0,
              //   },
              //   child: child,
              // );
            },
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: MyHomePage(
                      title: "Home Page",
                      current: DateTime.now(),
                    ),
                  );
                },
              ),
              GoRoute(
                path: "/home/:day",
                pageBuilder: (context, state) {
                  var unParsedDay = state.pathParameters["day"];
                  try {
                    DateTime parsedDay = DateTime.parse(unParsedDay!);
                    return FadeTransitionPage<dynamic>(
                      key: state.pageKey,
                      child: MyHomePage(
                          title: "Home Page", current: parsedDay
                      ),
                    );
                  } catch (e) {
                    print("error: $e");
                    return FadeTransitionPage<dynamic>(
                      key: state.pageKey,
                      child: MyHomePage(
                          title: "Home Page", current: DateTime.now()
                      ),
                    );
                  }
                },
              ),
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: myProfilePage,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/auth',
            pageBuilder: (context, state) {
              return FadeTransitionPage<dynamic>(
                key: state.pageKey,
                child: authPage,
              );
            },
          ),
        ],
      ),
    );
  }
}