import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/features/auth/presentation/pages/login_page.dart';
import 'package:konsul_dok/features/auth/presentation/pages/register_page.dart';
import 'package:konsul_dok/init_dependencies.dart';
import 'package:konsul_dok/pages/chat_page.dart';
import 'package:konsul_dok/pages/home_page.dart';
import 'package:konsul_dok/pages/jadwal_page.dart';
import 'package:konsul_dok/pages/profile_dokter.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/widgets/navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => serviceLocator<AuthBloc>(),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: MyColor.putih,
      home: Scaffold(
        body: page[selectedIndex],
        bottomNavigationBar: MyBottomNavigationBar(
          selectedIndex: selectedIndex,
          onItemTapped: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        // body: const LoginPage(),
      ),
    );
  }
}
