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
            return LoginScreen();
          },
        ),
        GoRoute(
          path: 'signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignupScreen();
          },
        ),
        GoRoute(
            path: 'patient/:uId',
            builder: (BuildContext context, GoRouterState state) {
              final String patientUid = state.pathParameters['uId']!;
              return PatientScreen(
                uId: patientUid,
              );
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'doctor_details/:doctorId/:patientId',
                builder: (BuildContext context, GoRouterState state) {
                  final doctorId = state.pathParameters['doctorId']!;
                  final patientId = state.pathParameters['patientId']!;

                  return DoctorDetailsScreen(
                    doctorUId: doctorId,
                    patientUId: patientId,
                  );
                },
              )
            ]),
        GoRoute(
          path: 'doctor/:uId/:date',
          builder: (BuildContext context, GoRouterState state) {
            final String doctorUid = state.pathParameters['uId']!;
            final String date = state.pathParameters['date']!;
            return DoctorScreen(
              uId: doctorUid,
              date: date,
            );
          },
        ),
      ],
    ),
  ],
);
