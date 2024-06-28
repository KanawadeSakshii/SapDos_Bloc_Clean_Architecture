import 'package:bloc_project/core/theme/theme.dart';
import 'package:bloc_project/dependencies/dependescies_imports.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_project/features/doctor/presentation/blocs/doctor_dashboard/bloc/doctor_dashboard_bloc.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_details/bloc/doctor_details_bloc.dart';
import 'package:bloc_project/features/patient/presentation/blocs/patient_bloc/patient_bloc.dart';
import 'package:bloc_project/utils/setuplogger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_strategy/url_strategy.dart';
import 'routes/route_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLogging();
  logger.info('Logger initialized');
  setupAuthLocator();
  setupDoctorDashBoardLocator();
  setUpPatientLocator();
  setPathUrlStrategy();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<DoctorDetailsBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<PatientBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<DoctorDashboardBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: AppTheme.lightThemeMode,
            routerConfig: appRouter,
          );
        });
  }
}
