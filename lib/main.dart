import 'package:flutter/material.dart';
import 'package:surveyflow/home.dart';
import 'package:surveyflow/splash_screen.dart';

void main() {
  runApp(const Surveyflow());
}

class Surveyflow extends StatelessWidget {
  const Surveyflow({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
