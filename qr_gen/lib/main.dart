import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/qr_gen.dart';
import 'pages/qr_scan.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeScreen(),
      '/gen': (context) => GenerateQR(),
      '/scan': (context) => ScanQR(),
    },
  ));
}