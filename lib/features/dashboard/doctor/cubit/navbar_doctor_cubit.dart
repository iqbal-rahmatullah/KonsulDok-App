import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:konsul_dok/features/dashboard/doctor/pages/homepage_doctor.dart';

import 'package:konsul_dok/features/dashboard/patient/pages/chat_page.dart';
import 'package:konsul_dok/features/dashboard/patient/pages/profile_page.dart';

class NavbarDoctorCubit extends Cubit<int> {
  NavbarDoctorCubit() : super(0);

  var page = [
    const HomepageDoctor(),
    const ChatPage(),
    const ProfilePage(),
  ];

  change(int i) => emit(i);
  Widget get pageNow => page[state];
}
