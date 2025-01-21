import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/Views/widgets/task.dart';
import 'package:task_manager/Views/widgets/taskForm.dart';

class TimeContainer extends StatefulWidget {
  //const TimeContainer ({required Key key, required this.date}) : super(key: key);
  TimeContainer({super.key, required this.date, this.task});

  final DateTime date;
  UserTaskUI? task;

  @override
  State<TimeContainer> createState() => TimeContainerState();
}
class TimeContainerState extends State<TimeContainer>{

  void handleAddTask(){

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows finer control over height
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16), // Rounded corners at the top
        ),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.50, // Quarter of the screen height
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Add padding for aesthetics
            child: TaskForm(defaultDate: widget.date,),
          ),
        );
      },
    );
  }
  bool compareNow(){
    var now = DateTime.now();
    return widget.date.year == now.year &&
        widget.date.month == now.month &&
        widget.date.day == now.day &&
        widget.date.hour == now.hour;  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 2.0,
            ),
          ),
        ),
        child: InkWell(
          onTap: widget.task != null ? null : handleAddTask,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget> [
              widget.task != null ? widget.task! :Spacer(),

              Spacer(),
              Text(compareNow() ? "NOW" : DateFormat('HH:mm').format(widget.date),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withValues(alpha: widget.task != null ? 1 : 0.8),
                  fontWeight: widget.task != null ? FontWeight.bold : null,
                ),

              ),

            ],
          ),
        )
    );

  }

}


