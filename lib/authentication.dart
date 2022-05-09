import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wtc/ui/home.dart';

Future<bool> loginWithPhone(BuildContext context, String phone) async {
  TextEditingController otpCtrller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  await auth.verifyPhoneNumber(
    phoneNumber: phone,
    codeAutoRetrievalTimeout: (txt) {},
    verificationCompleted: (PhoneAuthCredential credential) async {
      var result = await auth.signInWithCredential(credential);
      // FirebaseAuth.instance.currentUser
      User? user = result.user;
      if (user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(user: user),
            ));
      }
    },
    verificationFailed: (exception) {
      print(exception.toString());
    },
    codeSent: (String verificationId, int? resendToken) async {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Enter the OTP"),
              content: Column(
                children: [
                  TextField(
                    controller: otpCtrller,
                  )
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    AuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: otpCtrller.text,
                    );
                    var result = await auth.signInWithCredential(credential);
                    User? user = result.user;
                    if (user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(user: user),
                          ));
                    } else {
                      print("error");
                    }
                  },
                  child: const Text("Confirm"),
                )
              ],
            );
          });
      // await auth.signInWithCredential();
    },
  );
  return false;
}
