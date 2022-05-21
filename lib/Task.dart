import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';

// List<Location> locations;

class Task {
  String name;
  String location;
  int vacancy;
  int dailywage;
  String startdate;
  String enddate;
  String projectName;
  String skills;
  bool accomodation;
  // int? distance;

  Task({
    required this.name,
    required this.startdate,
    required this.enddate,
    required this.dailywage,
    required this.location,
    required this.vacancy,
    required this.accomodation,
    required this.projectName,
    required this.skills,
  });

  final CollectionReference todoRef =
      FirebaseFirestore.instance.collection('contractors');

  Future<void> addContractortask(Task task) async {
    var userid = FirebaseAuth.instance.currentUser!.uid;
    // final docRef = todoRef.doc(userid);

    Map<String, dynamic> taskmap = {
      'name': task.name,
      'location': task.location,
      'vacancy': task.vacancy,
      'dailywage': task.dailywage,
      'startdate': task.startdate,
      'enddate': task.enddate,
      'accomodation': task.accomodation,
      'pname': task.projectName,
      'skills': task.skills,
      // 'distance' : task.distance,
    };
    return todoRef.doc(userid).update({
      'task': FieldValue.arrayUnion([taskmap])
    });
  }
  // print(isApiData);
}
