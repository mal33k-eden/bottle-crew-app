import 'package:bottle_crew/pages/auth/register.dart';
import 'package:bottle_crew/pages/auth/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleAuthView() {
    print('helllp');

    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleAuthView: toggleAuthView);
    } else {
      return Register(toggleAuthView: toggleAuthView);
    }
  }
}
