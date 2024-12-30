import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../Model/Task.dart';
import '../Model/User.dart';
import '../Model/auth.dart';

class MainController extends ChangeNotifier {
  //The statemanagement implementation I went for was to utilize ChangeNotifier,
  //whenever we create a method we can use NotifyListeners() to easily update states in the app
  //for views to call functions or access date we can use Consumer and Provider.
  //read about Consumer and provider here:
  //https://docs.flutter.dev/data-and-backend/state-mgmt/simple

  late AppAuth _auth;
  late User _user;
  MainController() {
    _auth = AppAuth();
    _user = User.noName();
    _init();
  }

  get getAuth => _auth; //encapsulation for security, not allowing anyone to change _auth

  void _init(){

    //Test data
    _user.addTask(Task("poo", "hello", DateTime(0,0,0,0,0)));
    _user.addTask(Task("drink water", "drink 2L", DateTime(0,0,0,5)));
    _user.addTask(Task("be sigma", " so so sigma", DateTime(0,0,0,2)));
    _user.addTask(Task("be sigma 2", " so so sigma 2", DateTime(0,0,0,2)));

  }
  HashSet<Task> getTasks() {
    return _user.getTasks();
  }

  void addTask(Task task) {
    _user.addTask(task);
    notifyListeners(); //notifies everyone listening to update
  }
  void removeTask(Task task){
    _user.removeTask(task);
    notifyListeners();
  }





}