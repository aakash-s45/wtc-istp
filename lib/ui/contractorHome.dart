// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wtc/dbcontent.dart';
import 'package:wtc/provider.dart';
import 'package:wtc/ui/contrLocationDetail.dart';
import 'package:wtc/ui/worker_list.dart';

class HomeScreen extends ConsumerWidget {
  User? user;
  Position? currLocation;
  HomeScreen({Key? key, this.user}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int distance = 20;
  @override
  Widget build(BuildContext context, ref) {
    int distance = ref.watch(distanceDropdownoptionProvider);
    ref.read(currentPositionProvider.notifier).update();

    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.blueGrey,
          child: SafeArea(
            child: Column(children: [
              const SizedBox(width: 300),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                },
                title: const Text("Logout"),
                leading: const Icon(Icons.logout),
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
            Text("$distance Km"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DistWin(),
            ),
          ],
          title: const Text("Worker List"),
          backgroundColor: Colors.blueGrey,
        ),
        body: SingleChildScrollView(
          child: WorkerList(),
        ),
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add),
        onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ContractorDetail() ));
        },
      ),
    );
  }
}

// dont use drop down make our own widget
class DistWin extends ConsumerWidget {
  Position? currLocation;
  DistWin({Key? key, this.currLocation}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int distance = ref.watch(distanceDropdownoptionProvider);
    return IconButton(
      icon: const Icon(Icons.location_on),
      onPressed: () {
        List<int> distanceList = [20, 40, 60, 80];
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Choose distance'),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: SizedBox(
                height: 220,
                width: 300,
                child: ListView.builder(
                  itemCount: distanceList.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      ref
                          .read(distanceDropdownoptionProvider.notifier)
                          .update(distanceList[index]);
                      // distance = newValue!;
                    },
                    title: (distanceList[index] >= 80)
                        ? Text("${(distanceList[index])}+ Km")
                        : Text("${(distanceList[index])} Km"),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Continue');
                  try {
                    ref
                        .read(currentPositionProvider.notifier)
                        .update()
                        .whenComplete(() async {
                      Position tempLocation = ref.read(currentPositionProvider);
                      await updatelocation(tempLocation);
                    });
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        );
      },
    );
  }
}


// DropdownButton<int>(
//                 value: distance,
//                 icon: const Icon(Icons.arrow_downward),
//                 elevation: 16,
//                 style: const TextStyle(color: Colors.black),
//                 underline: Container(
//                   height: 2,
//                   color: Colors.grey,
//                 ),
//                 onChanged: (int? newValue) {
//                   ref
//                       .read(distanceDropdownoptionProvider.notifier)
//                       .update(newValue);
//                   // distance = newValue!;
//                 },
//                 items: <int>[20, 40, 60, 80]
//                     .map<DropdownMenuItem<int>>((int value) {
//                   return DropdownMenuItem<int>(
//                     value: value,
//                     child: Text('$value'),
//                   );
//                 }).toList(),
//               ),
            