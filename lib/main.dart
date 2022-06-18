import 'package:apinio_case_study/views/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apinio Case Study',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const HomeView(),
    );
  }
}
