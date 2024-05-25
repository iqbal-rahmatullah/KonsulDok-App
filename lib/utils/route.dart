import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/auth/presentation/pages/login_page.dart';
import 'package:konsul_dok/features/auth/presentation/pages/register_page.dart';
import 'package:konsul_dok/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:konsul_dok/features/doctor/presentation/pages/detail_dokter.dart';
import 'package:konsul_dok/features/doctor/presentation/pages/poli_page.dart';
import 'package:konsul_dok/main.dart';
import 'package:konsul_dok/pages/loading_page.dart';

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
            path: 'dokter/:id',
            name: "detail_dokter",
            builder: (context, state) {
              final String id = state.pathParameters['id']!;
              return const DetailDokter();
            },
          ),
        ],
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
], routerNeglect: true, initialLocation: '/loading');
