import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Model/Task.dart';
import 'package:task_manager/Views/widgets/Calendar_Scrollable_Section.dart';
import 'package:task_manager/Views/widgets/task.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/Views/widgets/taskForm.dart';

import '../Controllers/MainController.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.current});
  final String title;
  final DateTime current;

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
    final goRouter = GoRouter.of(context);


    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat.yMMMMd().format(widget.current),
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today, color: Colors.black),
              onPressed: () {
                goRouter.go("/calendar");
                //Navigator.pop(context);
              },
            ),
          ],

        ),


        //title: Text(widget.title),

      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints){

            return
              Stack(
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        CalendarScrollableSection(current: widget.current),

                        Expanded(child:
                        Consumer<MainController>(
                          builder: (context, controller, child) {
                            var data = controller.getTasks(widget.current).toList();
                            data.sort((a, b) => a.date.compareTo(b.date));
                            //print(data.toString());

                            final List<TimeContainer> timeContainers2 = [];
                            DateTime fromMidnight = widget.current.copyWith(hour: 0, minute: 0);

                            //int counter = 0; // counter for data
                            //create hashmap<int,List<TimeContainer>> for O(1)
                            //int being the hour
                            //for loop to add to the hashmap by hour
                            //then another for loop iterating the hashmap
                            //if the value list length > 1 then display multipleTask(List<TimeContainer>)
                            HashMap<int, List<TimeContainer>> found = HashMap();
                            for(int i = 0; i < data.length;i++){
                              TimeContainer container =
                              TimeContainer(date: data[i].date,
                                  task: UserTaskUI(task:data[i])
                              );
                              found.putIfAbsent(data[i].date.hour, () => []).add(container);
                              //counter++;
                            }

                            print(found.toString());
                            for (int i = 0; i < 24; i++) {
                              DateTime current = fromMidnight.add(Duration(hours: i));
                              if(found.containsKey(i) && found[i]!.length > 1){ // +1 to get from 0 index to 1 index
                                timeContainers2.add(found[i]!.first);
                              }else if (found.containsKey(i)) {
                                timeContainers2.add(found[i]!.first);
                              }
                              else{
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


