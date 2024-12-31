
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarScrollableSection extends StatefulWidget {
  const CalendarScrollableSection({super.key});

  @override
  State<CalendarScrollableSection> createState() => _CalendarScrollState();
}

class _CalendarScrollState extends State<CalendarScrollableSection>{
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints){
          return
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) =>
                    Container(
                      width: 150, // Adjust the width for each item
                      height: 50, // Adjust height as needed
                      color: Colors.green, // Set any color you want
                      margin: const EdgeInsets.only(right: 15), // Add spacing between items
                      child: Center(
                        child: Text(
                          'Item $index',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                ),
              ),
            );
        }
    );

  }

}