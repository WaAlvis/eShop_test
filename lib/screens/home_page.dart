import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  static String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}
