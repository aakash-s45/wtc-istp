import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wtc/ui/workertile.dart';

class HomeScreen extends StatelessWidget {
  User? user;
  HomeScreen({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.logout_outlined),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            }),
        body: Center(
          child: WorkerTile(
            src: const {
              "name": "Haldiram",
              "phone": "01125532553",
              "skill": "bohot tagdi",
              "exp": "Bohot jyada",
              "dob": "1995-11-30",
            },
          ),
          // child: Text("this is homescrren guys"),
        ));
  }
}
