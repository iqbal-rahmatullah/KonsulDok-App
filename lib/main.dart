import 'package:flutter/material.dart';
import 'package:konsul_dok/pages/chat_page.dart';
import 'package:konsul_dok/pages/home_page.dart';
import 'package:konsul_dok/pages/jadwal_page.dart';
import 'package:konsul_dok/pages/login_page.dart';
import 'package:konsul_dok/pages/profile_page.dart';
import 'package:konsul_dok/pages/register_page.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/widgets/navbar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var selectedIndex = 0;
  var page = [
    const HomePage(),
    const JadwalPage(),
    const ChatPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: MyColor.putih,
      home: Scaffold(
        body: page[selectedIndex],
        bottomNavigationBar: MyBottomNavigationBar(
          selectedIndex: selectedIndex,
          onItemTapped: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
