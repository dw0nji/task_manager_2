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

final appShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'app shell');

void main() {
  //runs the app with the provider being our MainController.
  //This allows the controller to manage/change the state of our views and also
  //communicate with out views
  runApp(
      ChangeNotifierProvider(
        create: (context) => MainController(),
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ProfilePage? myProfilePage;
  final loginPage = LoginPage();
  @override
  void initState() {
    super.initState();
    myProfilePage = ProfilePage(title: 'Profile Page'); // Assign ProfilePage.

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Task Manager App',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      routerConfig: GoRouter( //allows us to easily call pages within our navigation
        //                      and also allows us to wrap logic around each page
        //                      e.g. We can add extra security by wrapping a page with
        //                      our auth object from the controller to check whether someone
        //                      is signed in or not.
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
                    child: MyHomePage(title: "Home Page", current: DateTime.now()),
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
                      child: MyHomePage(title: "Home Page", current: parsedDay),
                    );
                  }catch (e){
                    print("error: $e");
                    return FadeTransitionPage<dynamic>(
                      key: state.pageKey,
                      child: MyHomePage(title: "Home Page", current: DateTime.now()),
                    );


                  }

                },
              ),
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: myProfilePage != null ? myProfilePage! : const Center(child: CircularProgressIndicator()),
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
                child: loginPage,
              );
            },
          ),

        ],

      ),

    );
  }
}

