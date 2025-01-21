import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../Model/Task.dart';
import '../Model/User.dart';
import '../Model/auth.dart';
import '../firebase_options.dart';
import 'DBController.dart';

class MainController extends ChangeNotifier {
  //The state management implementation I went for was to utilize ChangeNotifier,
  //whenever we create a method we can use NotifyListeners() to easily update states in the app
  //for views to call functions or access date we can use Consumer and Provider.
  //read about Consumer and provider here:
  //https://docs.flutter.dev/data-and-backend/state-mgmt/simple

  late AppAuth _auth;
  late User _user;

  MainController() {
    _auth = AppAuth();
    _user = User.noName();
    //Test data
    Task task = Task(title: "poo", description: "no", date: DateTime.now().add(Duration(days:1)), isRecurring: false, isCompleted: false);
    addTask(task);
    _user.retrieveTasksDb();
    notifyListeners();
  }

  get getAuth => _auth; //encapsulation for security, not allowing anyone to change _auth



  HashSet<Task> getTasks(DateTime? date) {
    return date == null ? _user.getTasks() : _user.getTasksByDay(date!);
  }

  void addTask(Task task) {
    _user.addTask(task);
    notifyListeners(); //notifies everyone listening to update
  }
  void removeTask(Task task){
    _user.removeTask(task);
    notifyListeners();
  }

  bool containsDate(DateTime comparable) {
    HashSet<Task> tasks = _user.getTasks();
    return tasks.any((task) =>
    task.date.year == comparable.year &&
        task.date.month == comparable.month &&
        task.date.day == comparable.day);
  }





}