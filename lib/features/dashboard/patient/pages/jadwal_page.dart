import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/appointment/data/model/appointment_patient_model.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment_patient.dart';
import 'package:konsul_dok/features/appointment/presentation/bloc/appointment_patient/bloc/appointment_patient_bloc.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/pages/card_transaction.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patient = context.read<AuthBloc>().state as AuthGetUserSuccess;
    BlocProvider.of<AppointmentPatientBloc>(context)
        .add(GetAppointmentPatientEvent(id: patient.user.id));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Jadwal',
          style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: MyColor.putihForm,
            ),
            onPressed: () {},
            child: const Icon(
              Icons.search,
              color: MyColor.abuForm,
            ),
          ),
        ],
        bottom: TabBar(
          tabs: const [
            Tab(
              text: "Belum Selesai",
            ),
            Tab(
              text: "Selesai",
            ),
          ],
          indicatorColor: MyColor.biruIndicator,
          labelColor: MyColor.biruIndicator,
          dividerColor: MyColor.abuForm,
          controller: _tabController,
        ),
      ),
      body: BlocConsumer<AppointmentPatientBloc, AppointmentPatientState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AppointmentPatientLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AppointmentPatientError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is AppointmentPatientLoaded) {
            List<AppointmentPatient> appointments = state.appointments
                .where((element) => element.status == "ongoing")
                .toList();

            List<AppointmentPatient> appointmentsDone = state.appointments
                .where((element) => element.status != "ongoing")
                .toList();

            return Padding(
              padding: MySpacing.paddingInsetPage.copyWith(top: 20),
              child: TabBarView(
                controller: _tabController,
                children: [
                  (appointments.isEmpty)
                      ? const Center(
                          child: Text(
                            "Tidak ada jadwal ditemukan",
                            style: MyTextStyle.deskripsi,
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              appointments.length,
                              (index) => cardTransaction(
                                context: context,
                                appointment: appointments[index],
                              ),
                            ),
                          ),
                        ),
                  (appointmentsDone.isEmpty)
                      ? const Center(
                          child: Text(
                            "Tidak ada jadwal ditemukan",
                            style: MyTextStyle.deskripsi,
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              appointmentsDone.length,
                              (index) => cardTransaction(
                                context: context,
                                appointment: appointmentsDone[index],
                                isOrdered: true,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
