import 'package:bottle_crew/models/crew.dart';
import 'package:flutter/material.dart';

class CrewTile extends StatelessWidget {
  final Crew? crew;
  const CrewTile({required this.crew, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[crew?.bottles ?? 100],
          ),
          title: Text(crew?.name ?? ''),
          subtitle: Text(crew?.type ?? ''),
        ),
      ),
    );
  }
}
