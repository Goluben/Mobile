import 'package:flutter/material.dart';
import 'package:rss_reader/services/newsDAO.dart';
import 'pages/home_page.dart';
import 'pages/web_view_page.dart';


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
      '/': (context) => HomePage(newsDAO: NewsDAO()),
      'view': (context) => const WebView(),
    });
  }
}
