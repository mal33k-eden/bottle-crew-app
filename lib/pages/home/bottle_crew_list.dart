import 'package:bottle_crew/models/crew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'crew_tile.dart';

class BottleCrewList extends StatefulWidget {
  const BottleCrewList({Key? key}) : super(key: key);

  @override
  _BottleCrewListState createState() => _BottleCrewListState();
}

class _BottleCrewListState extends State<BottleCrewList> {
  @override
  Widget build(BuildContext context) {
    // final bottlecrews = _snapshot;

    final bottlecrews = Provider.of<Iterable<Crew>?>(context) ?? [];

    return ListView.builder(
      itemBuilder: (context, index) {
        return CrewTile(crew: bottlecrews.elementAt(index));
      },
      itemCount: bottlecrews.length,
    );
  }
}
