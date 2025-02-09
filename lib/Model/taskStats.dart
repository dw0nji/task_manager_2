
import 'dart:collection';


import 'Task.dart';
import 'User.dart';

mixin TaskStats {
  HashSet<Task> tasks = HashSet<Task>();

  List<int> calculateLast30Days(){
    DateTime today = DateTime.now();
    DateTime thirtyDaysAgo = today.subtract(Duration(days: 30));
    List<int> zeros = List.generate(30, (index) => 0);
    for(Task task in tasks){

      if(task.date.isAfter(thirtyDaysAgo) && task.date.isBefore(today) && task.isCompleted){
        print (today.day - task.date.day);
        zeros[today.day - task.date.day] += 1;
      }
    }

    return zeros;
  }

  void calculateMonth(){

  }
  void calculateYear(){}

}



