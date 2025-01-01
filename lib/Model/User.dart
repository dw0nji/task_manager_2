import 'dart:collection';

import 'Task.dart';

class User {
  String username;
  HashSet<Task> tasks;
  User(this.username):
    tasks = HashSet<Task>();

  User.noName()
      : tasks = HashSet<Task>(),
  username = "";

  // Get the username
  String getUsername() {
    return username;
  }

  // Get all tasks
  HashSet<Task> getTasks() {
    return tasks;
  }
  HashSet<Task> getTasksByDay(DateTime time) {
    HashSet<Task> filteredTasks = HashSet();
    for(var task in tasks){
      //print("${task.title}: and ${task.date}");
      if (task.date.year == time.year &&
          task.date.month == time.month &&
          task.date.day == time.day) {
        filteredTasks.add(task); // Add the task if it matches
      }
    }
    return filteredTasks;
  }

  // Add a task
  void addTask(Task task) {
    tasks.add(task);
  }

  // Remove a task by object
  void removeTask(Task task) {
    tasks.remove(task);
  }

  // Remove a task by a key (assuming Task has a unique key)
  void removeTaskByKey(int key) {
    //
  }

  // Get tasks from the database (stubbed out, implement as needed)
  HashSet<Task> getTasksDb() {
    // Logic to retrieve tasks from the database
    return HashSet<Task>();
  }

  // Update tasks in the database (stubbed out, implement as needed)
  void updateTasksDb() {
    // Logic to update tasks in the database
  }

  // Remove tasks from the database (stubbed out, implement as needed)
  void removeTaskDb() {
    // Logic to remove tasks from the database
  }



}