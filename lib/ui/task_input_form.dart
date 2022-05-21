import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:conditional_questions/conditional_questions.dart';

import '../Task.dart';

class ContractorDetail extends StatelessWidget {
  const ContractorDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController location = TextEditingController();
    TextEditingController vacancy = TextEditingController();
    TextEditingController dailywage = TextEditingController();
    TextEditingController skillsController = TextEditingController();
    TextEditingController projectNameController = TextEditingController();
    String? startdate;
    String? enddate;
    bool accomodation = false;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Contractor task detail'),
          backgroundColor: Colors.grey,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width, //to get the width of screen
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: projectNameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.label),
                      hintText: 'Project Name',
                      labelText: 'Project name',
                    ),
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: name,
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: location,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.location_pin),
                      hintText: 'Enter your site location',
                      labelText: 'Site location*',
                    ),
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: skillsController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.location_pin),
                      hintText: 'Enter required skills',
                      labelText: 'Skills*',
                    ),
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: vacancy,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.numbers),
                      hintText: 'No. of worker required',
                      labelText: 'No. of worker required*',
                    ),
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: dailywage,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.money),
                      hintText: 'Enter daily wage amount',
                      labelText: 'daily wage amount*',
                    ),
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Time period',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DateTimePicker(
                          icon: const Icon(Icons.date_range),
                          initialValue: '',
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2100),
                          dateLabelText: 'Start date',
                          onChanged: (val) => startdate = val,
                          validator: (val) {
                            print(val);
                            return null;
                          },
                          onSaved: (val) => startdate = val,
                        ),
                      ),
                      Expanded(
                        child: DateTimePicker(
                          icon: const Icon(Icons.date_range),
                          initialValue: '',
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2100),
                          dateLabelText: 'End date',
                          onChanged: (val) => enddate = val,
                          validator: (val) {
                            print(val);
                            return null;
                          },
                          onSaved: (val) => enddate = val,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // PolarQuestion(
                  //     question: "Have you made any donations in the past?",
                  //       answers: ["Yes", "No"],
                  //     isMandatory: true,
                  //  )
                  CheckboxListTile(
                    title: Text("Accomodation"),
                    value: accomodation,
                    onChanged: (newValue) {
                      accomodation:
                      newValue;
                      print('accomodation');
                      print(accomodation);
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () async {
                      int wage = int.parse(dailywage.text);
                      int vaca = int.parse(vacancy.text);

                      Task task = Task(
                          name: name.text,
                          startdate: startdate ?? "NaN",
                          enddate: enddate ?? "NaN",
                          dailywage: wage,
                          location: location.text,
                          vacancy: vaca,
                          accomodation: accomodation,
                          projectName: "Test project",
                          skills: "abhi to nhi hai");
                      // Task(name.text, startdate, enddate, wage,
                      //     location.text, vaca);
                      await task.addContractortask(task);
                      Navigator.pop(context);
                    },
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
