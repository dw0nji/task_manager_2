import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Model/Task.dart';
import 'package:task_manager/Views/widgets/Calendar_Scrollable_Section.dart';
import 'package:task_manager/Views/widgets/task.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/Views/widgets/taskForm.dart';

import '../Controllers/MainController.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void taskFormPopup(){
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
            child: TaskForm(),
          ),
        );
      },
    );

  }


  @override
  Widget build(BuildContext context) {


    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Home Page"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints){

          return
            Stack(
              children: [
                Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  CalendarScrollableSection(),

                  Expanded(child:
                    Consumer<MainController>(
                      builder: (context, controller, child) {

                        // Get the current date and time from the device
                        DateTime now = DateTime.now();
                        DateTime fromMidnight = DateTime(now.year, now.month, now.day); // Start of the day at midnight

                        // Fetch tasks and sort them
                        var data = controller.getTasks(now).toList();
                        data.sort((a, b) => a.date.compareTo(b.date));

                        //print(data.toString());

                        // Process the tasks into time containers
                        final List<TimeContainer> timeContainers2 = [];
                        //DateTime(0,0,0,0,0,0,0);

                        int counter = 0; // counter for data
                        for (int i = 0; i < 24; i++) {
                          DateTime current = fromMidnight.add(Duration(hours: i));
                          if(counter < data.length && data[counter].date.hour == current.hour) {
                            TimeContainer container =
                            TimeContainer(date: current,
                                task: UserTaskUI(task:data[counter])
                            );
                            timeContainers2.add(container);

                            i--; // after a successfull add, try the same day to see if more exist
                            counter++;
                          }else{
                            TimeContainer container = TimeContainer(date: current);
                            timeContainers2.add(container);
                          }
                        }

                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints:
                            BoxConstraints(minHeight: viewportConstraints.maxHeight),

                            child:
                              Center(

                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: timeContainers2

                              ),
                            ),
                          ),
                        );
                      },
                    )
                  )
                ]
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(20.0),
                  child: 
                  FloatingActionButton(
                    onPressed: taskFormPopup,
                    //onPressed: (){Provider.of<MainController>(context, listen: false).addTask(Task("hello", "no", DateTime(0,0,0,15,20)));},
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )
                ),
              ],
          );
        }
      ),
      );
  }
}

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
          Text(compareNow() ? "NOW" : DateFormat('HH:mm').format(widget.date)),

        ],
        ),
      )
    );

  }

}


