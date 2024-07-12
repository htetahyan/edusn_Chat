import 'package:flutter/material.dart';
import 'package:flutter_edusn/Pages/aboutus.dart';

import 'package:flutter_edusn/Providers/chat_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
