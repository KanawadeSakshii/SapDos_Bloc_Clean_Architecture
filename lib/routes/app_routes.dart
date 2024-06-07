import 'package:bloc_project/features/auth/presentation/screens/signup_screen.dart';
import 'package:bloc_project/features/doctor/presentation/pages/doctor_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bloc_project/features/auth/presentation/screens/login_screen.dart';
import 'package:bloc_project/features/auth/presentation/screens/welcome_screen.dart';
import 'package:bloc_project/features/patient/presentation/pages/patient_screen.dart';

final GoRouter appRouter = GoRouter(
  // initialLocation: '/welcome',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyWelcomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: 'signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignupScreen();
          },
        ),
        GoRoute(
          path: 'patient',
          builder: (BuildContext context, GoRouterState state) {
            return const PatientScreen();
          },
        ),
        GoRoute(
          path: 'doctor',
          builder: (BuildContext context, GoRouterState state) {
            return const DoctorScreen();
          },
        ),
      ],
    ),
  ],
);
