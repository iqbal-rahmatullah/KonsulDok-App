import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/dashboard/patient/pages/home_page.dart';
import 'package:konsul_dok/features/dashboard/patient/pages/chat_page.dart';
import 'package:konsul_dok/features/dashboard/patient/pages/jadwal_page.dart';
import 'package:konsul_dok/features/dashboard/patient/pages/profile_page.dart';

class NavbarCubit extends Cubit<int> {
  NavbarCubit() : super(0);

  var page = [
    const HomePage(),
    const JadwalPage(),
    const ChatPage(),
    const ProfilePage(),
  ];

  change(int i) => emit(i);
  Widget get pageNow => page[state];
}
