import 'package:bottle_crew/models/user.dart';
import 'package:bottle_crew/pages/home/bottle_crew_list.dart';
import 'package:bottle_crew/services/database.dart';
import 'package:bottle_crew/shared/loader.dart';
import 'package:bottle_crew/shared/textFieldDecorator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _types = [
    'Alcohol',
    'Non-Alcohol',
  ];

  String? name;
  String? _type;
  int? _bottles;
  final ButtonStyle btnStyle = ElevatedButton.styleFrom(
      primary: Colors.brown,
      textStyle: const TextStyle(fontSize: 25),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20));
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BCUser?>(context);
    return StreamBuilder<BCUserData>(
        stream: DataBaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            BCUserData? bcUserData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Update your bottle crew settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: bcUserData?.name,
                    decoration: textFieldDecorator.copyWith(
                        label: const Text('Name'), hintText: 'Enter your name'),
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    value: _type ?? bcUserData!.type,
                    items: _types.map((t) {
                      return DropdownMenuItem(value: t, child: Text(t));
                    }).toList(),
                    hint: Text('Select Type'),
                    onChanged: (val) => setState(() {
                      _type = val as String?;
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Slider(
                      value: (_bottles ?? bcUserData!.bottle).toDouble(),
                      activeColor: Colors.amber[_bottles ?? bcUserData!.bottle],
                      inactiveColor:
                          Colors.brown[_bottles ?? bcUserData!.bottle],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (val) {
                        setState(() {
                          _bottles = val.round();
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: btnStyle,
                      onPressed: () async {
                        await DataBaseService(uid: user.uid).updateUserDate(
                            _type ?? bcUserData!.type,
                            name ?? bcUserData!.name,
                            _bottles ?? bcUserData!.bottle);
                        Navigator.pop(context);
                      },
                      child: const Text('Update'))
                ],
              ),
            );
          } else {
            return Loader();
          }
        });
  }
}
