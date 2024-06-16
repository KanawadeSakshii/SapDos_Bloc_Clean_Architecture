part of 'route_imports.dart';

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
            routes: <RouteBase>[
              GoRoute(
                path: 'doctor/:id',
                builder: (BuildContext context, GoRouterState state) {
                  final doctorId = state.pathParameters['id']!;
                  return DoctorDetailsScreen(
                    doctorId: doctorId,
                  );
                },
              )
            ]),
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
