import 'package:flutter/material.dart';
import 'package:task_manager/Views/widgets/task.dart';
import '../Model/Task.dart';
import 'package:intl/intl.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TimeContainer> _timeContainers = [];
  @override
  void initState() {
    super.initState();
    instantiateDay(); // Initialize 24 TimeContainer instances
  }
  void instantiateDay() {
    //add functionality to get all tasks from the Model Through the controller??
    setState(() {
      _timeContainers.clear();
      DateTime fromMidnight = DateTime(0,0,0,0,0,0,0);
      for (int i = 0; i < 24; i++) {
        _timeContainers.add(TimeContainer(date: fromMidnight.add(Duration(hours: i))));
      }
    });
  }

  void updateTasks() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints){
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),

              child: Center(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _timeContainers


                ),
              ),
            ),
          );
        }
      ),
      );
  }
}

class TimeContainer extends StatefulWidget {
  const TimeContainer({super.key, required this.date});

  final DateTime date;

  @override
  State<TimeContainer> createState() => _TimeContainerState();
}
class _TimeContainerState extends State<TimeContainer>{


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
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget> [
            UserTaskUI(title: 'Dishes',
              description: 'Clean mugs and plates.',
              date: DateTime.now()
            ),
            Spacer(),
            Text(DateFormat('HH:mm').format(widget.date)),

        ],
      ),
    );



  }

}
