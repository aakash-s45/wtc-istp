import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wtc/dbcontent.dart';
import 'package:wtc/ui/contractorHome.dart';

Future<void> loginWithPhone(
    {required BuildContext context,
    required String phone,
    String? name,
    String? dob,
    String? usertype}) async {
  TextEditingController otpCtrller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  await auth.verifyPhoneNumber(
    phoneNumber: phone,
    codeAutoRetrievalTimeout: (txt) {},
    verificationCompleted: (PhoneAuthCredential credential) async {
      var result = await auth.signInWithCredential(credential);
      User? user = result.user;
      if (user != null) {
        if (name != null && dob != null && usertype != null) {
          if (usertype == "Worker") {
            await addWorker(
                userid: user.uid,
                name: name,
                phone: phone,
                address: {'lat': 0, 'lon': 0},
                dob: dob);
          } else {
            await addContractor(
                userid: user.uid,
                name: name,
                phone: phone,
                address: {'lat': 0, 'lon': 0},
                dob: dob);
          }
        }
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(user: user),
            ),
            (Route<dynamic> route) => false);
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
                      if (name != null && dob != null && usertype != null) {
                        if (usertype == "Worker") {
                          await addWorker(
                              userid: user.uid,
                              name: name,
                              phone: phone,
                              address: {'lat': 0, 'lon': 0},
                              dob: dob);
                        } else {
                          await addContractor(
                              userid: user.uid,
                              name: name,
                              phone: phone,
                              address: {'lat': 0, 'lon': 0},
                              dob: dob);
                        }
                      }

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(user: user),
                          ),
                          (Route<dynamic> route) => false);
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
  // return false;
}
