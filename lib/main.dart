import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/features/auth/presentation/pages/login_page.dart';
import 'package:konsul_dok/features/auth/presentation/pages/register_page.dart';
import 'package:konsul_dok/init_dependencies.dart';
import 'package:konsul_dok/pages/chat_page.dart';
import 'package:konsul_dok/pages/home_page.dart';
import 'package:konsul_dok/pages/jadwal_page.dart';
import 'package:konsul_dok/pages/profile_dokter.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/route.dart';
import 'package:konsul_dok/widgets/navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => serviceLocator<AuthBloc>()..add(AuthGetUser()),
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
  var selectedIndex = 0;
  var page = [
    const HomePage(),
    const JadwalPage(),
    const ChatPage(),
    const ProfileDokter(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          router.go('/loading');
        } else if (state is AuthSuccess) {
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
        // home: Scaffold(
        //   body: page[selectedIndex],
        //   bottomNavigationBar: MyBottomNavigationBar(
        //     selectedIndex: selectedIndex,
        //     onItemTapped: (index) {
        //       setState(() {
        //         selectedIndex = index;
        //       });
        //     },
        //   ),
        //   // body: const LoginPage(),
        // ),
      ),
    );
  }
}
