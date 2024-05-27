import 'package:flutter/material.dart';

class NavbarItem {
  static List<Map> navbar = [
    {
      "icon": const Icon(Icons.home_outlined),
      "label": 'Beranda',
    },
    {
      "icon": const Icon(Icons.calendar_today),
      "label": 'Jadwal',
    },
    {
      "icon": const Icon(Icons.chat_bubble_outline),
      "label": 'Chat',
    },
    {
      "icon": const Icon(Icons.person_2_outlined),
      "label": 'Profil',
    },
  ];

  static const navbarDoctor = [
    {
      "icon": Icon(Icons.home_outlined),
      "label": 'Beranda',
    },
    {
      "icon": Icon(Icons.chat_bubble_outline),
      "label": 'Chat',
    },
    {
      "icon": Icon(Icons.person_2_outlined),
      "label": 'Profil',
    },
  ];
}
