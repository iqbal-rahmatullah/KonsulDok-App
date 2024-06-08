import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';

class NavbarItem {
  final int countChat;

  NavbarItem({required this.countChat});

  List<Map<String, dynamic>> getNavbarItems() {
    return [
      {
        "icon": const Icon(Icons.home_outlined),
        "label": 'Beranda',
      },
      {
        "icon": const Icon(Icons.calendar_today),
        "label": 'Jadwal',
      },
      {
        "icon": Stack(
          children: [
            const Icon(Icons.chat_bubble_outline),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: MyColor.biruIndicator,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  countChat.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        "label": 'Chat',
      },
      {
        "icon": const Icon(Icons.person_2_outlined),
        "label": 'Profil',
      },
    ];
  }

  List<Map<String, dynamic>> getNavbarDoctor() {
    return [
      {
        "icon": const Icon(Icons.home_outlined),
        "label": 'Beranda',
      },
      {
        "icon": Stack(
          children: [
            const Icon(Icons.chat_bubble_outline),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: MyColor.biruIndicator,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  countChat.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        "label": 'Chat',
      },
      {
        "icon": const Icon(Icons.person_2_outlined),
        "label": 'Profil',
      },
    ];
  }
}
