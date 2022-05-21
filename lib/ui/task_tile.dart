import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wtc/task.dart';

class TaskTile extends ConsumerWidget {
  Task task;
  TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 5,
              blurRadius: 12,
              offset: const Offset(0, 7), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: Colors.blueGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  task.projectName,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  "Contractor : ${task.name}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Wage: ${task.dailywage} rs/day",
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              "Location: ${task.location}",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        )),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Accomodation: ${(task.accomodation) ? "Yes" : "No"}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Vacancy: ${task.vacancy}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  "Timeperiod : ${task.startdate} to ${task.enddate}",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  "Skill required : ${task.skills}",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       task.name!,
        //       style: TextStyle(fontSize: 20),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
