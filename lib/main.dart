import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/features/dashboard/cubit/navbar_cubit.dart';
import 'package:konsul_dok/features/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:konsul_dok/init_dependencies.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/route.dart';

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
      BlocProvider<DoctorBloc>(
        create: (context) => serviceLocator<DoctorBloc>(),
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
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthGetUserSuccess) {
          router.go('/home');
        } else if (state is AuthFailure) {
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
