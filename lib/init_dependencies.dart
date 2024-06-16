import 'package:bloc_project/core/supabasedata/url_secrets.dart';
import 'package:bloc_project/features/authenticate/domain/usecases/user_sign_up.dart';
import 'package:bloc_project/features/authenticate/data/datasources/auth_remote_data.dart';
import 'package:bloc_project/features/authenticate/domain/repository/auth_repo.dart';
import 'package:bloc_project/features/authenticate/data/repoIMPL/auth_repo_impl.dart';
import 'package:bloc_project/features/authenticate/presentation/bloc/auth_bloc.dart';
import 'package:bloc_project/features/patient/data/repository/doctorrepoimpl.dart';
import 'package:bloc_project/features/patient/domain/repository/doctorrepo.dart';
import 'package:bloc_project/features/patient/domain/usecases/doctor_detail_usecase.dart';
import 'package:bloc_project/features/patient/domain/usecases/get_doctor_by_id_use_case.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_bloc.dart';
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

// doctor
void setupDoctorLocator() {
  // Register use cases
  serviceLocator
      .registerLazySingleton(() => GetDoctorDetailsUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => GetDoctorByIdUseCase(serviceLocator()));
  // Register repositories
  serviceLocator
      .registerLazySingleton<DoctorRepository>(() => DoctorRepositoryImpl());

  // Register bloc
  serviceLocator.registerFactory(() => DoctorDetailsBloc(
        serviceLocator<GetDoctorDetailsUseCase>(),
        serviceLocator<GetDoctorByIdUseCase>(),
      ));
}
