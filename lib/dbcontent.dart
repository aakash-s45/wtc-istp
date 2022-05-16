import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

var collRef1 = FirebaseFirestore.instance.collection('/workers');
var collRef2 = FirebaseFirestore.instance.collection('/contractors');

Future<bool> doesNameAlreadyExistHelper(String phone, String coll) async {
  final QuerySnapshot result = await FirebaseFirestore.instance
      .collection(coll)
      .where('phone', isEqualTo: phone)
      .limit(1)
      .get();
  final List<DocumentSnapshot> documents = result.docs;
  return documents.length == 1;
}

Future<bool> doesNameAlreadyExist(String number) async {
  var res1 = await doesNameAlreadyExistHelper(number, "workers");
  var res2 = await doesNameAlreadyExistHelper(number, "contractors");
  return res1 || res2;
}

Future<void> addWorker(
    {required String userid,
    required String name,
    required String phone,
    required String address,
    required String dob}) {
  return collRef1
      .doc(userid)
      .set({
        'id': userid,
        'name': name,
        'address': address,
        'dob': dob,
        'phone': phone,
        'skill': "",
        'exp': ""
      })
      .then((value) => print("Worker Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> addContractor(
    {required String userid,
    required String name,
    required String phone,
    required String address,
    required String dob}) {
  return collRef2
      .doc(userid)
      .set({
        'id': userid,
        'name': name,
        'address': address,
        'dob': dob,
        'task': [],
        'phone': phone
      })
      .then((value) => print("Contractor Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

int isAdult(String birthDateString) {
  String datePattern = "yyyy-mm-dd";

  DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
  DateTime today = DateTime.now();

  int yearDiff = today.year - birthDate.year;
  int monthDiff = today.month - birthDate.month;
  int dayDiff = today.day - birthDate.day;

  return (yearDiff > 18 ||
          yearDiff == 18 && monthDiff > 0 ||
          yearDiff == 18 && monthDiff == 0 && dayDiff >= 0)
      ? yearDiff
      : -1;
}
