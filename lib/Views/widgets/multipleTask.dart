//This file will include the drop down task widget for handling multiple tasks for one day.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/Task.dart';

class MultipleTask extends StatelessWidget{
  const MultipleTask({super.key, required this.tasks});
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: (){},
            child: Icon(
              Icons.circle_outlined,
              size: 24,
            ),

    );
  }

}