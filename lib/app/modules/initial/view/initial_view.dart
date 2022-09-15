import 'package:flutter/material.dart';

class InitialView extends StatelessWidget {
  const InitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'This assignment completed by Gesya Gayatree Solih',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
