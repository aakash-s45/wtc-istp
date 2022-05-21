import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wtc/dbcontent.dart';
import 'package:wtc/provider.dart';
import 'package:wtc/ui/workertile.dart';

class WorkerList extends ConsumerWidget {
  const WorkerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _workerlist = ref.watch(workerListStream);
    return _workerlist.when(
        data: (event) {
          return Column(
            children: [
              ...event.docs.map((doc) {
                var tempdoc = doc.data();
                Map tempworkerloc = tempdoc['address'];

                Position contPos = ref.read(currentPositionProvider);
                var tempDistanceBetween = calculateDistance(
                    contPos.latitude,
                    contPos.longitude,
                    tempworkerloc['lat'],
                    tempworkerloc['lon']);
                print(tempDistanceBetween);

                int selectedDist = ref.read(distanceDropdownoptionProvider);
                return (selectedDist < 80 &&
                        tempDistanceBetween <= selectedDist)
                    ? WorkerTile(
                        src: tempdoc,
                      )
                    : WorkerTile(src: tempdoc);
              }).toList()
            ],
          );
        },
        error: (e, stk) => Text(e.toString()),
        loading: () => const CircularProgressIndicator());
  }
}
