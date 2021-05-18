import 'package:flutter/material.dart';
import 'package:flutter_translation_app/screens/HistoryPage.dart';
import 'package:flutter_translation_app/screens/MainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UT Translator',
      routes: {
        '/history': (context) => HistoryPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

