import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListScene extends StatefulWidget {
  final DateTime selectedDate;

  ListScene({required this.selectedDate});

  @override
  _ListSceneState createState() => _ListSceneState();
}

class _ListSceneState extends State<ListScene> {
  late DateTime currentWeekStart;

  @override
  void initState() {
    super.initState();
    currentWeekStart = widget.selectedDate.subtract(Duration(days: widget.selectedDate.weekday - 1));
  }

  void _updateSelectedDate(DateTime newDate) {
    setState(() {
      widget.selectedDate == newDate;
    });
  }

  void _scrollWeek(int delta) {
    setState(() {
      currentWeekStart = currentWeekStart.add(Duration(days: delta * 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {"time": "08:00", "task": "Publish App", "description": "Description"},
      {"time": "11:00", "task": "3 Tasks", "description": ""},
      {"time": "15:00", "task": "Finish Analysis of App", "description": "Include Design"},
      {"time": "17:00", "task": "Escape the Matrix", "description": ""},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat.yMMMMd().format(widget.selectedDate),
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(14, (index) {
                final date = currentWeekStart.add(Duration(days: index));
                final isToday = date == DateTime.now();
                final isSelected = widget.selectedDate == date;
                return GestureDetector(
                  onTap: () => _updateSelectedDate(date),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.grey.shade300,
                      shape: BoxShape.circle,
                      border: Border.all(color: isToday ? Colors.red : Colors.transparent, width: 2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('E').format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('d').format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Column(
                  children: [
                    ListTile(
                      leading: GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.circle_outlined,
                            color: index % 2 == 0 ? Colors.red : Colors.orange,
                          ),
                        ),
                      ),
                      title: Text(task['task']!),
                      subtitle: task['description']!.isNotEmpty
                          ? Text(task['description']!)
                          : null,
                      trailing: Text(task['time']!),
                    ),
                    if (task['task'] == "3 Tasks")
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Subtask 1"),
                            ),
                            ListTile(
                              title: Text("Subtask 2"),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
