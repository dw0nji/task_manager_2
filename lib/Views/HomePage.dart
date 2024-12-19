import 'package:flutter/material.dart';
import 'package:task_manager/widgets/task.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
                  children: <Widget>[
                    Container(
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
                      child:UserTaskUI(title: 'Dishes', description: 'Clean mugs and plates.', date: DateTime.now()),
                    ),
                    UserTaskUI(title: 'Homework', description: 'Finish assignments.', date: DateTime.now()),
                  ],
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget> [
            UserTaskUI(title: 'Dishes',
              description: 'Clean mugs and plates.',
              date: DateTime.now()
            ),
            Text(widget.date.toString()),
        ],
      ),
    );



  }

}
