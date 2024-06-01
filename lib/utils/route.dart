import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment_patient.dart';
import 'package:konsul_dok/features/appointment/presentation/pages/detail_janji_pasien.dart';
import 'package:konsul_dok/features/appointment/presentation/pages/order_page.dart';
import 'package:konsul_dok/features/appointment/presentation/pages/success_order_page.dart';
import 'package:konsul_dok/features/auth/presentation/pages/login_page.dart';
import 'package:konsul_dok/features/auth/presentation/pages/register_page.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/features/chat/presentation/pages/chat_open.dart';
import 'package:konsul_dok/features/dashboard/doctor/pages/dashboard_doctor.dart';
import 'package:konsul_dok/features/dashboard/patient/pages/dashboard_page.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/features/doctor/presentation/pages/detail_dokter.dart';
import 'package:konsul_dok/features/doctor/presentation/pages/poli_page.dart';
import 'package:konsul_dok/main.dart';
import 'package:konsul_dok/pages/loading_page.dart';
import 'package:konsul_dok/utils/success_order/success_order_args.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    name: "root",
    builder: (context, state) {
      return const MainApp();
    },
  ),
  GoRoute(
    path: '/login',
    name: "login",
    builder: (context, state) {
      return const LoginPage();
    },
  ),
  GoRoute(
    path: '/register',
    name: "register",
    builder: (context, state) {
      return const RegisterPage();
    },
  ),
  GoRoute(
    path: '/home',
    name: "home",
    builder: (context, state) {
      return const DashboardPage();
    },
    routes: [
      GoRoute(
        path: 'poli/:name',
        name: "poli",
        builder: (context, state) {
          final String name = state.pathParameters['name']!;
          return PoliPage(
            namaPoli: name,
          );
        },
        routes: [
          GoRoute(
            path: 'orderpoli',
            name: "order_from_poli",
            builder: (context, state) {
              final Map<String, dynamic> extraData =
                  state.extra as Map<String, dynamic>;
              final Doctor doctor = extraData['doctor'] as Doctor;

              return OrderPage(doctor: doctor);
            },
          ),
          GoRoute(
              path: 'dokter/:id',
              name: "detail_dokter",
              builder: (context, state) {
                final String id = state.pathParameters['id']!;
                final Map<String, dynamic> extraData =
                    state.extra as Map<String, dynamic>;

                final Doctor doctor = extraData['doctor'] as Doctor;

                return DetailDokter(
                  id: id,
                  doctor: doctor,
                );
              },
              routes: [
                GoRoute(
                  path: 'chat_dokter/:name_dokter',
                  name: "chat_dokter",
                  builder: (context, state) {
                    final doctorState = state.pathParameters['name_dokter']!;
                    final Map<String, dynamic> extraData =
                        state.extra as Map<String, dynamic>;
                    final List<ChatDetail> chats =
                        extraData['chats'] as List<ChatDetail>;
                    return ChatOpenPage(
                        chat: chats, receipeintName: doctorState);
                  },
                ),
                GoRoute(
                  path: 'order',
                  name: "order",
                  builder: (context, state) {
                    final Map<String, dynamic> extraData =
                        state.extra as Map<String, dynamic>;
                    final Doctor doctor = extraData['doctor'] as Doctor;
                    return OrderPage(doctor: doctor);
                  },
                ),
              ]),
        ],
      ),
      GoRoute(
          path: "detail_appointment",
          name: "detail_appointment",
          builder: (context, state) {
            return DetailJanjiPasien(
              appointmentPatient: state.extra as AppointmentPatient,
            );
          }),
      GoRoute(
        path: "open_chat/:name",
        name: "open_chat",
        builder: (context, state) {
          final List<ChatDetail> chats = state.extra as List<ChatDetail>;
          return ChatOpenPage(
            chat: chats,
            receipeintName: state.pathParameters['name']!,
          );
        },
      ),
    ],
  ),
  GoRoute(
    path: '/home_doctor',
    name: "home_doctor",
    builder: (context, state) {
      return const DashboardDoctorPage();
    },
    routes: [
      GoRoute(
        path: "detail_appointment_doctor",
        name: "detail_appointment_doctor",
        builder: (context, state) {
          return DetailJanjiPasien(
            appointmentPatient: state.extra as AppointmentPatient,
            pageDoctor: true,
          );
        },
      )
    ],
  ),
  GoRoute(
    path: '/loading',
    name: "loading",
    builder: (context, state) {
      return const LoadingPage();
    },
  ),
  GoRoute(
    path: '/success_order',
    name: "success_order",
    builder: (context, state) {
      return SuccesOrderPage(
        args: state.extra as SuccessOrderArgs,
      );
    },
  ),
], routerNeglect: true, initialLocation: '/loading');
