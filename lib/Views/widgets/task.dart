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
    var customColor = Colors.red;
    if (DateTime.now().difference(widget.task.date).inHours > -5 && widget.task.date.isAfter(DateTime.now())){
      customColor = Colors.orange;
    }else if (widget.task.date.isAfter(DateTime.now())) {
      customColor = Colors.green;
    }

    return GestureDetector(
        onTap: destroy,
        child: Visibility(
          child: Row(
          spacing: 5,
          children: <Widget>[

          Icon(
            Icons.circle_outlined,
            color: customColor,
            size: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 0,
          children: <Widget>[
            Text(
              textAlign: TextAlign.left,
              style: TextStyle(fontSize:20, fontWeight: FontWeight.w500),
              widget.task.title,
            ),
            Text(
              textAlign: TextAlign.left,

              style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
              widget.task.description,
            ),
          ],
        ),
          ]
        ),
        )
    );
  }

}