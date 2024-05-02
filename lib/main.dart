import 'package:flutter/material.dart';
import 'package:konsul_dok/pages/home_page.dart';
import 'package:konsul_dok/pages/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Color(0xffffffff),
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}
