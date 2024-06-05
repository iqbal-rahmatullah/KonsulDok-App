import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:konsul_dok/features/appointment/presentation/bloc/appointment_patient/bloc/appointment_patient_bloc.dart';
import 'package:konsul_dok/features/appointment/presentation/bloc/clock_appointment/bloc/clock_appointment_bloc.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/add_chat/add_chat_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/all_chat/chat_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/get_chat_doctor/get_chat_doctor_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/message_by_id/message_by_id_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/open_chat/open_chat_bloc.dart';
import 'package:konsul_dok/features/dashboard/doctor/cubit/navbar_doctor_cubit.dart';
import 'package:konsul_dok/features/dashboard/patient/cubit/navbar_cubit.dart';
import 'package:konsul_dok/features/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:konsul_dok/features/rating/presentation/bloc/rating_bloc.dart';
import 'package:konsul_dok/init_dependencies.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/route.dart';
import 'package:konsul_dok/utils/socket/bloc/socket_bloc.dart';
import 'package:konsul_dok/utils/socket/socket_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => serviceLocator<AuthBloc>()..add(AuthGetUser()),
      ),
      BlocProvider<NavbarCubit>(
        create: (context) => serviceLocator<NavbarCubit>(),
      ),
      BlocProvider<NavbarDoctorCubit>(
        create: (context) => serviceLocator<NavbarDoctorCubit>(),
      ),
      BlocProvider<DoctorBloc>(
        create: (context) => serviceLocator<DoctorBloc>(),
      ),
      BlocProvider<AppointmentBloc>(
        create: (context) => serviceLocator<AppointmentBloc>(),
      ),
      BlocProvider<AppointmentPatientBloc>(
        create: (context) => serviceLocator<AppointmentPatientBloc>(),
      ),
      BlocProvider<ClockAppointmentBloc>(
        create: (context) => serviceLocator<ClockAppointmentBloc>(),
      ),
      BlocProvider<ChatBloc>(
        create: (context) => serviceLocator<ChatBloc>()..add(GetChatsEvent()),
      ),
      BlocProvider<AddChatBloc>(
        create: (context) => serviceLocator<AddChatBloc>(),
      ),
      BlocProvider<MessageByIdBloc>(
        create: (context) => serviceLocator<MessageByIdBloc>(),
      ),
      BlocProvider<GetChatDoctorBloc>(
        create: (context) => serviceLocator<GetChatDoctorBloc>(),
      ),
      BlocProvider<OpenChatBloc>(
        create: (context) => serviceLocator<OpenChatBloc>(),
      ),
      BlocProvider<RatingBloc>(
        create: (context) => serviceLocator<RatingBloc>(),
      ),
      BlocProvider<SocketBloc>(
        create: (context) =>
            SocketBloc(socketConfig: SocketConfig(context: context)),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthGetUserSuccess) {
          if (state.user.role == 'patient') {
            router.go('/home');
          } else {
            router.goNamed('home_doctor');
          }
        } else if (state is AuthLogoutSuccess || state is AuthFailure) {
          router.go('/login');
        }
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        color: MyColor.putih,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
      ),
    );
  }
}
