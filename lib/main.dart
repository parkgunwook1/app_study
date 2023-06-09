import 'package:flutter/material.dart';
import 'package:myapp/screens/main_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chat app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        ),
      home: const LoginSignupScreen(),
    );
  }
}
