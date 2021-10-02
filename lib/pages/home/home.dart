import 'package:bottle_crew/models/crew.dart';
import 'package:bottle_crew/pages/home/bottle_crew_list.dart';
import 'package:bottle_crew/pages/home/settings_form.dart';
import 'package:bottle_crew/services/auth.dart';
import 'package:bottle_crew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPannel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<Iterable<Crew>?>.value(
      value: DataBaseService(uid: '').bottlecrews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.amber[50],
        appBar: AppBar(
          title: Text('Bottle Crew'),
          backgroundColor: Colors.amber[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
                onPressed: () async {
                  await _authService.signOut();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.brown,
                ),
                label: const Text('logout')),
            TextButton.icon(
                onPressed: () {
                  _showSettingsPannel();
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.brown,
                ),
                label: const Text('Settings')),
          ],
        ),
        body: BottleCrewList(),
      ),
    );
  }
}
