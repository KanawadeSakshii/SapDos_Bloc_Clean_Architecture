import 'package:bloc_project/core/supabasedata/url_secrets.dart';
import 'package:bloc_project/features/authenticate/domain/usecases/user_sign_up.dart';
import 'package:bloc_project/features/authenticate/data/datasources/auth_remote_data.dart';
import 'package:bloc_project/features/authenticate/domain/repository/auth_repo.dart';
import 'package:bloc_project/features/authenticate/data/repoIMPL/auth_repo_impl.dart';
import 'package:bloc_project/features/authenticate/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/authenticate/domain/usecases/user_login.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  final supabase = await Supabase.initialize(
    url: UrlSecrets.supabaseurl,
    anonKey: UrlSecrets.supabaseanonkey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  // Datasource

  serviceLocator.registerFactory<AuthRemoteData>(() => AuthRemoteDataImpl(
        serviceLocator(),
      ));

  serviceLocator.registerFactory<AuthRepository>(() => AuthRepoImpl(
        serviceLocator(),
      ));

  serviceLocator.registerFactory(() => UserSignUp(
        serviceLocator(),
      ));

  serviceLocator.registerFactory(() => UserLogin(
        serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
      ));
}
