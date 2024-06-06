import 'package:bloc_project/core/theme/theme.dart';
import 'package:bloc_project/features/auth/presentation/screens/welcome_screen.dart';
import 'package:bloc_project/features/authenticate/presentation/bloc/auth_bloc.dart';
import 'package:bloc_project/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightThemeMode,
      home: const MyWelcomePage(),
    );
  }
}
