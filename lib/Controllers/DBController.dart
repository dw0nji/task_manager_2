import 'package:cloud_firestore/cloud_firestore.dart';

class DBController {
  late FirebaseFirestore db ;


  DBController (){
    db = FirebaseFirestore.instance;

  }
}