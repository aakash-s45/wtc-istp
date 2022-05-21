

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Task{
  String? name;
  String? location;
  int? vacancy;
  int? dailywage;
  DateTime? startdate;
  DateTime? enddate;
  // int? distance;

  Task(this.name, this.startdate,this.enddate, this.dailywage, this.location,this.vacancy);

  final CollectionReference todoRef = FirebaseFirestore.instance.collection('contractor');

  Future<void> addContractortask(Task task) async {
    var userid = FirebaseAuth.instance.currentUser!.uid;
    // final docRef = todoRef.doc(userid);



      Map<String, dynamic> taskmap = {
        'name': task.name,
        'rating': task.location,
        'vacancy': task.vacancy,
        'dailywage' : task.dailywage,
        'startdate' : task.startdate,
        'enddate': task.enddate,
        // 'distance' : task.distance,
      };
      return todoRef.doc(userid).update({
        'task': FieldValue.arrayUnion([taskmap])
      });
    }
    // print(isApiData);
  }




