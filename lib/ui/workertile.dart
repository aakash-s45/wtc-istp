import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wtc/dbcontent.dart';
import 'package:wtc/provider.dart';

class WorkerTile extends ConsumerWidget {
  var src;
  WorkerTile({Key? key, required this.src}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    int age = isAdult(src["dob"]);
    Map tempworkerloc = src['address'];
    Position contPos = ref.read(currentPositionProvider);
    double workerDistance = calculateDistance(contPos.latitude,
        contPos.longitude, tempworkerloc['lat'], tempworkerloc['lon']);

    // int distance=

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 170,
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
                  src["name"],
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
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
                              "Age : $age",
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              "Distance : ${workerDistance.toInt()} Km",
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              "Exp : ${src["exp"]}",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          children: [
                            const Text(
                              "Skills",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            ...src['skill']
                                .map(
                                  (val) => Text(
                                    val,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                )
                                .toList(),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
