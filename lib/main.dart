import 'package:flutter/material.dart';
import 'package:flutter_edusn/Pages/aboutus.dart';
import 'package:flutter_edusn/Pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AboutUs(),
    );
  }
}
