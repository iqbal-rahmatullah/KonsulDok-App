import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/dashboard/presentation/pages/home_page.dart';
import 'package:konsul_dok/features/dashboard/presentation/pages/chat_page.dart';
import 'package:konsul_dok/features/dashboard/presentation/pages/jadwal_page.dart';
import 'package:konsul_dok/features/dashboard/presentation/pages/profile_dokter.dart';

class NavbarCubit extends Cubit<int> {
  NavbarCubit() : super(0);

  var page = [
    const HomePage(),
    const JadwalPage(),
    const ChatPage(),
    const ProfileDokter(),
  ];

  change(int i) => emit(i);
  Widget get pageNow => page[state];
}
