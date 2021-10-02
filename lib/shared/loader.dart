import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[100],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.amber[600],
          size: 50,
        ),
      ),
    );
  }
}
