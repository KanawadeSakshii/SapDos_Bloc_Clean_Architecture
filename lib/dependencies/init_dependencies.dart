part of 'dependescies_imports.dart';

final serviceLocator = GetIt.instance;
void navigateTo(String routeName) {
  appRouter.go(routeName);
}

void setupAuthLocator() {
  serviceLocator.registerLazySingleton<Logger>(() => logger);
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource());

  // User Repository
  serviceLocator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      remoteDataSource: serviceLocator<AuthRemoteDataSource>()));

  serviceLocator.registerFactory<RegisterUseCase>(
      () => RegisterUseCase(serviceLocator<UserRepository>()));
  serviceLocator.registerFactory<LoginUseCase>(
      () => LoginUseCase(serviceLocator<UserRepository>()));

  serviceLocator.registerFactory<AuthBloc>(() => AuthBloc(
        register: serviceLocator<RegisterUseCase>(),
        login: serviceLocator<LoginUseCase>(),
        remoteDataSource: serviceLocator<RemoteDataSource>(),
        navigate: navigateTo,
      ));
}

// doctor
void setupDoctorDashBoardLocator() {
  // Register RemoteDataSource
  serviceLocator
      .registerLazySingleton<RemoteDataSource>(() => RemoteDataSource());

  // Register Repository
  serviceLocator.registerLazySingleton<DoctorDashboardRepositoryimpl>(
      () => DoctorDashboardRepositoryimpl(serviceLocator<RemoteDataSource>()));

  // Register PatientRepositoryImpl
  serviceLocator.registerLazySingleton<PatientRepository>(() =>
      PatientRepositoryImpl(
          remoteDataSource: serviceLocator<RemoteDataSource>()));

  // Register Use Cases
  serviceLocator.registerLazySingleton<GetDoctorDashboardUsecase>(() =>
      GetDoctorDashboardUsecase(
          serviceLocator<DoctorDashboardRepositoryimpl>()));
  serviceLocator.registerLazySingleton<GetDoctorByIdUseCase>(() =>
      GetDoctorByIdUseCase(serviceLocator<DoctorDashboardRepositoryimpl>()));
  serviceLocator.registerLazySingleton<GetPatientByIdUseCase>(() =>
      GetPatientByIdUseCase(repository: serviceLocator<PatientRepository>()));

  // Register BLoC
  serviceLocator.registerFactory<DoctorDashboardBloc>(() => DoctorDashboardBloc(
        getDoctorDashboardUsecase: serviceLocator<GetDoctorDashboardUsecase>(),
        getDoctorByIdUseCase: serviceLocator<GetDoctorByIdUseCase>(),
      ));
}

void setUpPatientLocator() {
  serviceLocator.registerLazySingleton<RemoteDataSourcePatient>(
    () => RemoteDataSourcePatient(),
  );

  serviceLocator.registerFactory<PatientBloc>(
    () => PatientBloc(serviceLocator<GetPatientByIdUseCase>()),
  );

  serviceLocator.registerLazySingleton<DoctorRepository>(
    () => DoctorRepositoryImpl(
        remoteDataSourcePatient: serviceLocator<RemoteDataSourcePatient>()),
  );

  serviceLocator.registerLazySingleton<GetAllDoctorsUseCase>(
    () => GetAllDoctorsUseCase(repository: serviceLocator<DoctorRepository>()),
  );
  serviceLocator.registerLazySingleton<GetAvailableSlotsUseCase>(
      () => GetAvailableSlotsUseCase(serviceLocator<DoctorRepository>()));
  serviceLocator.registerLazySingleton<BookAppointmentUseCase>(
      () => BookAppointmentUseCase(serviceLocator<DoctorRepository>()));

  serviceLocator.registerFactory<DoctorDetailsBloc>(
    () => DoctorDetailsBloc(
        getAllDoctorsUseCase: serviceLocator<GetAllDoctorsUseCase>(),
        getDoctorByIdUseCase: serviceLocator<GetDoctorByIdUseCase>(),
        getAvailableSlotsUseCase: serviceLocator<GetAvailableSlotsUseCase>(),
        bookAppointmentUseCase: serviceLocator<BookAppointmentUseCase>()),
  );
}
