import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'Task.dart';

class User {
  String username;
  HashSet<Task> tasks;
  late FirebaseFirestore _db ;

  User(this.username):
    tasks = HashSet<Task>(),

    _db = FirebaseFirestore.instance;


  User.noName():
        tasks = HashSet<Task>(),
        username = "",
        _db = FirebaseFirestore.instance;

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

  Future<void> retrieveTasksDb() async {

    //TODO: Add auth check

    DocumentReference userRef = _db.doc('/User/User'); //TODO: change this to user $user


    //gets all the documents by UserID
    final docRef = _db
        .collection("Tasks")
        .where('UserID', isEqualTo: userRef)
        .withConverter<Task>(
      fromFirestore: Task.fromFirestore, //tells firestore what to do with the custom datatype
      toFirestore: (Task task, _) => task.toFirestore(userRef), //same here
    );

    docRef.get().then(
          (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          try {
            Task data = docSnapshot.data();
            addTask(data);
          }catch(e){
            print("conversion failed");
          }

          //print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

  }

  Future<void> addTasksDb() async {
    DocumentReference userRef = _db.doc('/User/$username');

    final docRef = _db
        .collection("Tasks")
        .withConverter<Task>(
      fromFirestore: Task.fromFirestore,
      toFirestore: (Task task, _) => task.toFirestore(userRef),
    );
    for(Task task in tasks){
      docRef.add(task);
    }

  }
  Future<void> addTaskDb(Task task) async {
    DocumentReference userRef = _db.doc('/User/$username');

    final docRef = _db
        .collection("Tasks")
        .withConverter<Task>(
      fromFirestore: Task.fromFirestore,
      toFirestore: (Task task, _) => task.toFirestore(userRef),
    );
    docRef.add(task);


  }

  void removeTaskDb() {
    // Logic to remove tasks from the database
  }



}