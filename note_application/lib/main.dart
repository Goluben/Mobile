import 'package:flutter/material.dart';
import 'package:note_application/pages/add_page.dart';
import 'package:note_application/services/file_system.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', 
      routes: {
      '/': (context) => HomePage(
            fs: FileSystem(),
          ),
      'add': (context) => const AddPage(),
    });
  }
}
