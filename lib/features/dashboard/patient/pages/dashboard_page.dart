import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/dashboard/patient/cubit/navbar_cubit.dart';
import 'package:konsul_dok/widgets/navbar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: BlocProvider.of<NavbarCubit>(context).pageNow,
          bottomNavigationBar: MyBottomNavigationBar(
            selectedIndex: state,
            onItemTapped: (index) {
              context.read<NavbarCubit>().change(index);
            },
          ),
        );
      },
    );
  }
}
