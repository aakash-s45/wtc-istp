import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wtc/ui/home.dart';
import 'package:wtc/ui/login.dart';

final authProvider = Provider((ref) => FirebaseAuth.instance);
final loginNum = Provider((ref) => TextEditingController());
final authStateStream =
    StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetAuth(),
    ),
  ));
}

class GetAuth extends ConsumerWidget {
  const GetAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _authStream = ref.watch(authStateStream);
    return Scaffold(
      body: Center(
        child: _authStream.when(
          data: (user) {
            if (user == null) {
              return Login();
            } else {
              return HomeScreen(user: user);
            }
          },
          error: (e, stk) => Text(e.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}


// Future<Widget> getLandingPage() async {
//   return StreamBuilder<User?>(
//     stream: FirebaseAuth.instance.authStateChanges(),
//     builder: (BuildContext context, snapshot) {
//       if (snapshot.hasData && (!snapshot.data!.isAnonymous)) {
//         print("Logged in:- main");
//         return Scaffold(body: Text("Hello"));
//       }
//       print("Logged out:- main");
//       return Scaffold(body: Text("Hello"));
//       // return Text("hi");
//     },
//   );
// }
