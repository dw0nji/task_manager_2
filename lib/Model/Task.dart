import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  Task({required this.title,required this.description,required this.date, required this.isRecurring, required this.isCompleted});
  String title;
  String description;
  DateTime date;
  bool isRecurring;
  bool isCompleted;

  //factory functions that allows for unique datatype retrieval
  factory Task.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Task(
      title: data?['Title'],
      description: data?['Description'],
      date: (data?['DueDate'] as Timestamp).toDate(),
      isRecurring: data?['isRecurring'],
      isCompleted: data?['isCompleted'],
    );
  }

  Map<String, dynamic> toFirestore(DocumentReference ref) {
    return {
      "Title": title,
      "Description": description,
      "UserID": ref,
      "DueDate": Timestamp.fromDate(date),
      "isCompleted" : false,
      "isRecurring" : false,

    };
  }
  @override
  String toString(){
    return "Title $title, Description $description, Date $date";

  }
}