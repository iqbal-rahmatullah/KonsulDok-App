import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/appointment/presentation/bloc/appointment_patient/bloc/appointment_patient_bloc.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/features/dashboard/patient/cubit/navbar_cubit.dart';
import 'package:konsul_dok/features/dashboard/patient/pages/loading/loading_home_page.dart';
import 'package:konsul_dok/utils/const.dart';
import 'package:konsul_dok/utils/socket/bloc/socket_bloc.dart';
import 'package:konsul_dok/widgets/card_transaction.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/socket/socket_config.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_poliklinik.dart';
import 'package:konsul_dok/widgets/custom_snackbar.dart';
import 'package:konsul_dok/widgets/text_action.dart';
import 'package:konsul_dok/widgets/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthGetUserSuccess) {
            BlocProvider.of<AppointmentPatientBloc>(context)
                .add(GetAppointmentPatientEvent());
            context.read<SocketBloc>().add(SocketConnect(
                  state.user.id,
                ));

            return BlocBuilder<AppointmentPatientBloc, AppointmentPatientState>(
              builder: (context, state) {
                if (state is AppointmentPatientLoaded) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: MySpacing.paddingPage,
                      child: Column(
                        children: [
                          topBar(),
                          searchInput(),
                          menuPoliklinik(),
                          riwayatJanji(),
                        ],
                      ),
                    ),
                  );
                }
                return const LoadingHomePage();
              },
            );
          }
          return const LoadingHomePage();
        },
      ),
    );
  }

  Widget topBar() {
    final authState = context.read<AuthBloc>().state as AuthGetUserSuccess;

    return Container(
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
                "Halo",
                style: MyTextStyle.subheder
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(authState.user.name,
                  style: MyTextStyle.subheder.copyWith(
                    fontWeight: FontWeight.w800,
                  )),
            ],
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.notifications_active,
          //     color: MyColor.biru,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget searchInput() {
    return Container(
        margin: MySpacing.defaultMarginItem,
        child: textField(
            hintText: "Cari poliklinik",
            prefixIcon: const Icon(Icons.search),
            onTap: () {
              showModalPoli(focus: true);
            }));
  }

  Widget menuPoliklinik() {
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Poliklinik",
                style: MyTextStyle.subheder,
              ),
              textAction(
                  onTap: () {
                    showModalPoli();
                  },
                  text: "Lihat semua"),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 4,
            shrinkWrap: true,
            children: List.generate(8, (index) {
              return buttonPoliklinik(
                title: polikliknik[index]['name']!,
                image: polikliknik[index]['image']!,
                context: context,
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> showModalPoli({bool focus = false}) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            textField(
              hintText: "Cari poliklinik",
              prefixIcon: const Icon(Icons.search),
              controller: TextEditingController(),
              isFocus: focus,
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              shrinkWrap: true,
              children: List.generate(polikliknik.length, (index) {
                return buttonPoliklinik(
                  title: polikliknik[index]['name']!,
                  image: polikliknik[index]['image']!,
                  context: context,
                );
              }),
            ),
          ]),
        );
      },
    );
  }

  Widget riwayatJanji() {
    final appointmentState = context.read<AppointmentPatientBloc>().state
        as AppointmentPatientLoaded;

    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Riwayat jadwal janji",
                style: MyTextStyle.subheder,
              ),
              textAction(
                  onTap: () {
                    context.read<NavbarCubit>().change(1);
                  },
                  text: "Lihat semua"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (appointmentState.appointments.isEmpty)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: MyColor.putihForm,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/empty_janji.png',
                      width: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Anda belum memiliki jadwal janji dengan dokter.",
                      style: MyTextStyle.deskripsi.copyWith(
                        color: MyColor.abuForm,
                      ),
                    )
                  ],
                ),
              ),
            )
          else
            Column(
              children: List.generate(
                (appointmentState.appointments.length > 3)
                    ? 3
                    : appointmentState.appointments.length,
                (index) => cardTransaction(
                  context: context,
                  appointment: appointmentState.appointments[index],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
