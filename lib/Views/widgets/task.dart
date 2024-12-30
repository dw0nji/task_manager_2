import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controllers/MainController.dart';
import '../../Model/Task.dart';

class UserTaskUI extends StatefulWidget {
  const UserTaskUI(
  {super.key,
    required this.task,
  }
);
  final Task task;

  @override
  State<UserTaskUI> createState() => _UserTaskState();
}

class _UserTaskState extends State<UserTaskUI>{

  void destroy(){
    Provider.of<MainController>(context, listen: false).removeTask(widget.task);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: destroy,
        child: Visibility(
          child: Column(
          children: <Widget>[
            Text(
              widget.task.title,
            ),
            Text(
              widget.task.description,
            ),
          ],
        ),
        )
    );
  }

}