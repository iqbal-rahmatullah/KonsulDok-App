import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment_patient.dart';
import 'package:konsul_dok/features/appointment/presentation/bloc/appointment_patient/bloc/appointment_patient_bloc.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/pages/card_transaction.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/socket/socket_config.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class HomepageDoctor extends StatefulWidget {
  const HomepageDoctor({super.key});

  @override
  State<HomepageDoctor> createState() => _HomepageDoctorState();
}

class _HomepageDoctorState extends State<HomepageDoctor>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late SocketConfig socketConfig;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    socketConfig = SocketConfig(context: context);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctor = context.read<AuthBloc>().state as AuthGetUserSuccess;
    BlocProvider.of<AppointmentPatientBloc>(context)
        .add(GetAppointmentDoctorEvent(id: doctor.user.id));

    return Scaffold(
      appBar: AppBar(
        title: topBar(),
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
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
            socketConfig.connect(doctor.user.id);

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
                                pageDoctor: true,
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
                                pageDoctor: true,
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

  Widget topBar() {
    final authState = context.read<AuthBloc>().state as AuthGetUserSuccess;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        margin: MySpacing.defaultMarginItem,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/images/small_icon.png'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Halo, ",
                  style: MyTextStyle.subheder
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                Text(
                  authState.user.name,
                  style: MyTextStyle.subheder.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_active,
                color: MyColor.biru,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
