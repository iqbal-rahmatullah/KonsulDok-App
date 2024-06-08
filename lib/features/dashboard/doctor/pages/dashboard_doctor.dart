import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/all_chat/chat_bloc.dart';
import 'package:konsul_dok/features/dashboard/doctor/cubit/navbar_doctor_cubit.dart';
import 'package:konsul_dok/features/dashboard/patient/cubit/navbar_cubit.dart';
import 'package:konsul_dok/utils/navbar_item.dart';
import 'package:konsul_dok/widgets/navbar.dart';

class DashboardDoctorPage extends StatefulWidget {
  const DashboardDoctorPage({super.key});

  @override
  State<DashboardDoctorPage> createState() => _DashboardDoctorPageState();
}

class _DashboardDoctorPageState extends State<DashboardDoctorPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarDoctorCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: BlocProvider.of<NavbarDoctorCubit>(context).pageNow,
          bottomNavigationBar: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, stateChat) {
              if (stateChat is ChatLoaded) {
                int countChat = stateChat.chats.fold(
                    0,
                    (previousValue, element) =>
                        previousValue + element.countChat!);

                return MyBottomNavigationBar(
                  itemNavbar:
                      NavbarItem(countChat: countChat).getNavbarDoctor(),
                  selectedIndex: state,
                  onItemTapped: (index) {
                    context.read<NavbarDoctorCubit>().change(index);
                  },
                );
              }
              return MyBottomNavigationBar(
                itemNavbar: NavbarItem(countChat: 0).getNavbarDoctor(),
                selectedIndex: state,
                onItemTapped: (index) {
                  context.read<NavbarDoctorCubit>().change(index);
                },
              );
            },
          ),
        );
      },
    );
  }
}
