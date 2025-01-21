//This file will include the drop down task widget for handling multiple tasks for one day.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Views/widgets/time_container.dart';

import 'expansion_panel.dart';


class MultipleTask extends StatefulWidget {
  const MultipleTask({super.key, required this.tasks});

  final List<TimeContainer> tasks;


  @override
  State<MultipleTask> createState() => _MultipleTaskState();
}

class _MultipleTaskState extends State<MultipleTask> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool expanded) {
        setState(() {
          //print("setting state with ${expanded}");
          isOpen = expanded;



        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return const ListTile(
              title: Text('Tasks for Today'),
            );
          },
          isExpanded: isOpen,
          body: Column(
            children: widget.tasks.map((task) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: task,
            )).toList(),
          ),
        ),
      ],
    );
  }

}