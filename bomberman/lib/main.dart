import 'package:flutter/material.dart';

import 'homepage.dart';
import 'menu.dart';

  void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Menu(),
      '/game': (context) => HomePage(),
    },
  ));
}
