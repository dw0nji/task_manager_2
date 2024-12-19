import 'package:flutter/material.dart';
import 'package:task_manager/scaffold.dart';

import 'HomePage.dart';
import 'ProfilePage.dart';
import 'auth.dart';
import 'fade_transition_page.dart';
import 'loginPage.dart';
import 'package:go_router/go_router.dart';

final appShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'app shell');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  final AppAuth auth = AppAuth();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Task Manager App',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        //refreshListenable: auth,
        debugLogDiagnostics: true,
        initialLocation: '/home',
        // redirect: (context, state) {
        // final signedIn = BookstoreAuth.of(context).signedIn;
        // if (state.uri.toString() != '/sign-in' && !signedIn) {
        // return '/sign-in';
        // }
        // return null;
        // },
        routes: [
          ShellRoute(
            navigatorKey: appShellNavigatorKey,
            builder: (context, state, child) {
              return TaskManagerScaffold(
                selectedIndex: switch (state.uri.path) {
                  var p when p.startsWith('/home') => 0,
                  var p when p.startsWith('/profile') => 1,
                  //var p when p.startsWith('/settings') => 2,
                  _ => 0,
                },
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: const MyHomePage(title: 'Home Page'),
                  );
                },
              ),
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: ProfilePage(title: 'ProfilePage', auth: auth),
                  );
                },
              ),

            ],

          ),
          GoRoute(
            path: '/login',
            pageBuilder: (context, state) {
              return FadeTransitionPage<dynamic>(
                key: state.pageKey,
                child: const SignInHttp(title: 'Login Page'),
              );
            },
          ),

        ],

      ),

    );
  }
}

