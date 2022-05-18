import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wtc/dbcontent.dart';
import 'package:wtc/location.dart';

final distanceDropdownoptionProvider =
    StateNotifierProvider<Distance, int>((ref) {
  return Distance();
});

class Distance extends StateNotifier<int> {
  Distance() : super(20);
  void update(int? val) => state = (val != null) ? val : state;
}

final currentPositionProvider =
    StateNotifierProvider<CurrentLocation, Position>(
  (ref) => CurrentLocation(),
);

final workerListStream = StreamProvider((ref) {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  return collRef1.where("id", isNotEqualTo: uid).snapshots();
});

final workerListProvider = StateNotifierProvider<WorkerListState, List>((ref) {
  return WorkerListState();
});

class WorkerListState extends StateNotifier<List> {
  WorkerListState() : super([]);

  Future<void> update(snapshot) async {
    state.add(snapshot);
  }
}

class CurrentLocation extends StateNotifier<Position> {
  CurrentLocation()
      : super(Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
        ));
  Future<void> update() async {
    state = await determinePosition();
  }
}



/*
db
    .collection("cities")
    .where("state", isEqualTo: "CA")
    .snapshots()
    .listen((event) {
  final cities = [];
  for (var doc in event.docs) {
    cities.add(doc.data()["name"]);
  }
  print("cities in CA: ${cities.join(", ")}");
});
firestore.dart


*/ 