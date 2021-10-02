import 'package:bottle_crew/models/user.dart';
import 'package:bottle_crew/pages/auth/auth.dart';
import 'package:bottle_crew/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BCUser?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
    //checks auth changes
    //return home of auth widget
    return Authenticate();
  }
}
