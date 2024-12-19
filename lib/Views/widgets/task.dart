import 'package:flutter/material.dart';

class UserTaskUI extends StatefulWidget {
  const UserTaskUI(
  {super.key,
    required this.title,
    this.description,
    required this.date,
  }

);
  final String title;
  final String? description;
  final DateTime date;

  @override
  State<UserTaskUI> createState() => _UserTaskState();
}

class _UserTaskState extends State<UserTaskUI>{
  bool showChild= true;

  void destroy(){
    setState(() {
      showChild = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: destroy,
        child: Visibility(
          visible: showChild,
          child: Column(
          children: <Widget>[
            Text(
              widget.title,
            ),
            Text(
              widget.description   ?? '',
            ),
          ],
        ),
        )
    );
  }

}