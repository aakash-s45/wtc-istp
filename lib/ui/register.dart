import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController adharnum = TextEditingController();

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
              SizedBox(height: 20),
              // Container(
              //   height: 200,
              //   child: CupertinoDatePicker(
              //     mode: CupertinoDatePickerMode.date,
              //     initialDateTime: DateTime(2000, 1, 1),
              //     onDateTimeChanged: (DateTime newDateTime) {
              //       // Do something
              //     },
              //   ),
              // ),
              DateTimePicker(
                icon: Icon(Icons.date_range),
                initialValue: '',
                firstDate: DateTime(1970),
                lastDate: DateTime(2100),
                dateLabelText: 'Date',
                onChanged: (val) => print(val),
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: phoneNum,
                keyboardType: TextInputType.number,
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                // ],
                decoration: const InputDecoration(
                    labelText: "Phone number",
                    hintText: "Phone number",
                    icon: Icon(Icons.phone_iphone)),

                validator: (String? value) {
                  return (value != null && value.length < 10)
                      ? 'Invalid number'
                      : null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: adharnum,
                keyboardType: TextInputType.number,
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                // ],
                decoration: InputDecoration(
                    labelText: "Aadhar number",
                    hintText: "Aadhar number",
                    icon: Icon(Icons.note_rounded)),
                validator: (String? value) {
                  return (value != null && value.length < 12)
                      ? 'Invalid Adhar number'
                      : null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  onPrimary: Colors.white,
                ),
                onPressed: () {},
                child: Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
