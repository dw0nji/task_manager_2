import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'dart:math';

class DayStatWidget extends StatelessWidget {
  final List<int> taskCounts;

  const DayStatWidget({super.key, required this.taskCounts});

  Color getCommitColor(int count) {
    if (count == 0) return Colors.grey[300]!;
    if (count < 3) return Colors.green[100]!;
    if (count < 6) return Colors.green[300]!;
    if (count < 10) return Colors.green[500]!;
    return Colors.green[700]!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(4),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, // Represents days of the week
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: taskCounts.length,
        itemBuilder: (context, index) {
          return Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: getCommitColor(taskCounts[index]),
              borderRadius: BorderRadius.circular(3),
            ),
          );
        },
      ),
    );
  }
}
