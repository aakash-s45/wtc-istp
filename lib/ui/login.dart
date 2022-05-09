import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wtc/authentication.dart';
import 'package:wtc/main.dart';
import 'package:wtc/ui/register.dart';

class Login extends ConsumerWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final TextEditingController numController = ref.watch(loginNum);

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: Column(
          children: [
            Flexible(
              flex: 9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 40),
                  const Text(
                    "Welcome to WTC",
                    style: TextStyle(fontSize: 28),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: numController,
                    decoration: const InputDecoration(
                      labelText: "Phone",
                      hintText: "Enter your phone number",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await loginWithPhone(context, numController.text);
                      },
                      child: Text("Continue"),
                      //   style: ButtonStyle(
                      //       // minimumSize:
                      //       //     MaterialStateProperty.all(Size.square(70)),
                      //       // shape: MaterialStateProperty.all(StadiumBorder())),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Center(
                child: Row(
                  children: [
                    const Text(
                      "New User? ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
