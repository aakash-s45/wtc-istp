// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wtc/location.dart';
import 'package:wtc/ui/workertile.dart';

final countProvider = StateNotifierProvider<Distance, int>((ref) {
  return Distance();
});

class Distance extends StateNotifier<int> {
  Distance() : super(20);
  void update(int? val) => state = (val != null) ? val : state;
}

class HomeScreen extends ConsumerWidget {
  User? user;
  HomeScreen({Key? key, this.user}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int distance = 20;
  @override
  Widget build(BuildContext context, ref) {
    int distance = ref.watch(countProvider);
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.blueGrey,
          child: SafeArea(
            child: Column(children: [
              const SizedBox(width: 300),
              ListTile(
                title: const Text("Logout"),
                leading: IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                ),
              ),
            ]),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                print(determinePosition().toString());
              },
              icon: Icon(Icons.location_searching_rounded),
            ),
            Text(distance.toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DistWin(),
            ),
          ],
          title: const Text("Worker List"),
          backgroundColor: Colors.blueGrey,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              WorkerTile(
                src: const {
                  "name": "Haldiram",
                  "phone": "01125532553",
                  "skill": ["bohot tagdi", "main hu mistri"],
                  "exp": "Bohot jyada",
                  "dob": "1995-11-30",
                },
              ),
            ],
          ),
        ));
  }
}

// dont use drop down make our own widget
class DistWin extends ConsumerWidget {
  DistWin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    int distance = ref.watch(countProvider);
    return IconButton(
      icon: const Icon(Icons.location_on),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Choose distance'),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: DropdownButton<int>(
                value: distance,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (int? newValue) {
                  ref.read(countProvider.notifier).update(newValue);
                  // distance = newValue!;
                },
                items: <int>[20, 40, 60, 80]
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value'),
                  );
                }).toList(),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Continue'),
                child: const Text('Continue'),
              ),
            ],
          ),
        );
      },
    );
  }
}
