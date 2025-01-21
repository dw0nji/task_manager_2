import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/Views/ListScene.dart';
import 'package:task_manager/Views/ProfilePage.dart';

import 'HomePage.dart'; // Import ProfilePage

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalendarScene(),
  ));
}

class CalendarScene extends StatefulWidget {
  const CalendarScene({super.key});
  @override
  _CalendarSceneState createState() => _CalendarSceneState();
}

class _CalendarSceneState extends State<CalendarScene> {
  DateTime focusedMonth = DateTime.now(); // Tracks the currently visible month

  //yo = Provider of Main Controller
  //yo.getTasks();
  // Sample events for demonstration
  final Map<DateTime, List<String>> events = {
    DateTime(2025, 1, 5): ["Uni Ends"],
    DateTime(2025, 1, 16): ["Cheeky Getaway", "In Glasgow"],
    DateTime(2025, 1, 23): ["Gym", "Christmas", "Family Gathering"],
  };

  // Get the first day of the month
  DateTime _firstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  // Get the last day of the month
  DateTime _lastDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  // Navigate to the ListScene for a selected date
  void _goToDatePage(DateTime date) {
    final goRouter = GoRouter.of(context);

    goRouter.go("/home/${date}");
    //
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         ListScene(selectedDate: date)
    //         //MyHomePage(current: date, title: 'HomePage',),
    //   ),
    // );
  }

  // Update the focused month (swipe up or down)
  void _updateFocusedMonth(int delta) {
    setState(() {
      focusedMonth = DateTime(focusedMonth.year, focusedMonth.month + delta, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);


    final firstDayOfMonth = _firstDayOfMonth(focusedMonth);
    final lastDayOfMonth = _lastDayOfMonth(focusedMonth);
    final daysInMonth = lastDayOfMonth.day;

    // Start with the weekday of the first day of the month
    final startingWeekday = firstDayOfMonth.weekday;

    // Create a list of dates for the calendar
    List<DateTime?> days = [];
    for (int i = 1; i < startingWeekday; i++) {
      days.add(null); // Empty slots for alignment
    }
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(focusedMonth.year, focusedMonth.month, i));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat.yMMMM().format(focusedMonth),
              style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.black),
              onPressed: () {
                // Navigate to ProfilePage when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo is OverscrollNotification) {
            if (scrollInfo.overscroll < 0) {
              _updateFocusedMonth(-1); // Swipe down to go to the previous month
            } else {
              _updateFocusedMonth(1); // Swipe up to go to the next month
            }
          }
          return true;
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align all children to the left
            children: [
              DropdownButton<String>(
                value: "My Inbox",
                underline: Container(),
                items: [
                  DropdownMenuItem(
                    value: "My Inbox",
                    child: Text("My Inbox"),
                  ),
                  DropdownMenuItem(
                    value: "Work Team",
                    child: Text("Work Team"),
                  ),
                ],
                onChanged: (value) {},
                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              ),
              // Calendar Grid
              GridView.builder(
                shrinkWrap: true,
                itemCount: 7,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  const days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
                  return Center(
                    child: Text(
                      days[index],
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
              Divider(color: Colors.grey[400]),
              Expanded(
                child: ListView.separated(
                  itemCount: (days.length / 7).ceil(),
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0), // Horizontal padding of 10
                    child: Divider(color: Colors.grey[200]),
                  ),
                  itemBuilder: (context, weekIndex) {
                    return Row(
                      children: List.generate(7, (dayIndex) {
                        final dateIndex = weekIndex * 7 + dayIndex;
                        if (dateIndex >= days.length) return Expanded(child: Container());
                        final date = days[dateIndex];
                        final isToday = date != null &&
                            date.year == DateTime.now().year &&
                            date.month == DateTime.now().month &&
                            date.day == DateTime.now().day;

                        final dayEvents = date != null ? events[date] : null;

                        return Expanded(
                          child: GestureDetector(
                            onTap: date != null ? () => _goToDatePage(date) : null,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: isToday ? Colors.red : Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (date != null)
                                    Text(
                                      DateFormat('d').format(date),
                                      style: TextStyle(
                                        color: isToday ? Colors.white : Colors.grey[900],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  if (dayEvents != null)
                                    Column(
                                      children: dayEvents.take(3).map((event) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: event.contains("Christmas")
                                                  ? Colors.green
                                                  : event.contains("Gym")
                                                  ? Colors.red
                                                  : Colors.blue,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              event,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}