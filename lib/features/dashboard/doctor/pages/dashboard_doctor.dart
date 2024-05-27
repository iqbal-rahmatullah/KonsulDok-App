import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          bottomNavigationBar: MyBottomNavigationBar(
            itemNavbar: NavbarItem.navbarDoctor,
            selectedIndex: state,
            onItemTapped: (index) {
              context.read<NavbarDoctorCubit>().change(index);
            },
          ),
        );
      },
    );
  }
}
