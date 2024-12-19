import 'dart:collection';

import 'Task.dart';

class User {
  String username;
  HashSet<Task> tasks;
  User(this.username):
    tasks = new HashSet<Task>();

  // Get the username
  String getUsername() {
    return username;
  }

  // Get all tasks
  HashSet<Task> getTasks() {
    return tasks;
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