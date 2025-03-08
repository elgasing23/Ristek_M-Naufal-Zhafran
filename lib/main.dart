import 'package:flutter/material.dart';
import 'package:ristek_todoapp/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Fibra',
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MyWidget(),
    );
  }
}
