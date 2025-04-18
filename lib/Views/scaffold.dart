import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskManagerScaffold extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const TaskManagerScaffold({
    required this.child,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);
    return Scaffold(
      body: child,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (idx) {
          if (idx == 0) goRouter.go('/home');
          if (idx == 1) goRouter.go('/profile');
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

