import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateButton extends StatelessWidget {
  final String number; // Expected to be a date string in "yyyy-MM-dd" format
  final Function()? onTap;

  const DateButton({
    super.key,
    required this.number,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Parse the date from the passed string
    DateTime buttonDate = DateFormat("yyyy-MM-dd").parse(number);

    // Get today's date
    DateTime today = DateTime.now();
    bool isToday =
        buttonDate.year == today.year && buttonDate.month == today.month && buttonDate.day == today.day;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12), // Adjust padding for proper circle sizing
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Makes the container a perfect circle
          color: isToday ? Colors.red : Colors.grey[200], // Background color
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          DateFormat('d').format(buttonDate), // Extract day of the month
          style: TextStyle(
            color: isToday ? Colors.white : Colors.red, // Text color
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}