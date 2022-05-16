import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:wtc/authentication.dart';
import 'package:wtc/dbcontent.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController adharnum = TextEditingController();
  String usertype = "Worker";
  String? dob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: username,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Name',
                  labelText: 'Name *',
                ),
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
              ),
              const SizedBox(height: 20),
              DateTimePicker(
                icon: const Icon(Icons.date_range),
                initialValue: '',
                firstDate: DateTime(1970),
                lastDate: DateTime(2100),
                dateLabelText: 'Date',
                onChanged: (val) => dob = val,
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => dob = val,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: phoneNum,
                keyboardType: TextInputType.number,
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                // ],
                decoration: const InputDecoration(
                  labelText: "Phone number",
                  hintText: "Phone number",
                  icon: Icon(Icons.phone_iphone),
                ),

                validator: (String? value) {
                  return (value != null && value.length < 10)
                      ? 'Invalid number'
                      : null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: adharnum,
                keyboardType: TextInputType.number,
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                // ],
                decoration: const InputDecoration(
                    labelText: "Aadhar number",
                    hintText: "Aadhar number",
                    icon: Icon(Icons.note_rounded)),
                validator: (String? value) {
                  return (value != null && value.length < 12)
                      ? 'Invalid Adhar number'
                      : null;
                },
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Text("User Type"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: DropdownButton<String>(
                      value: usertype,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          usertype = newValue!;
                        });
                      },
                      items: <String>["Worker", "Contractor"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  onPrimary: Colors.white,
                ),
                onPressed: () async {
                  String number = phoneNum.text;
                  number = "+91" + number;
                  await doesNameAlreadyExist(number).then(((isExist) async {
                    if (isExist == false) {
                      await loginWithPhone(
                              context: context,
                              phone: number,
                              name: username.text,
                              dob: dob,
                              usertype: usertype)
                          .whenComplete(() {
                        phoneNum.clear();
                        username.clear();
                        adharnum.clear();
                      });
                    } else {
                      print("moj kr");
                      return const SnackBar(content: Text("Moj kr"));
                    }
                  }));
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
