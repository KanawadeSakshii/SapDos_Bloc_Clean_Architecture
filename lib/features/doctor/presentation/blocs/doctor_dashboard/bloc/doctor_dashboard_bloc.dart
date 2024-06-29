import 'package:bloc/bloc.dart';
import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_dashboard_model.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_model.dart';
import 'package:bloc_project/features/doctor/domain/Usecase/get_doctor_dashboard_usecase.dart';
import 'package:bloc_project/features/doctor/domain/Usecase/get_doctor_usecase.dart';
import 'package:bloc_project/utils/setuplogger.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

part 'doctor_dashboard_event.dart';
part 'doctor_dashboard_state.dart';

class DoctorDashboardBloc
    extends Bloc<DoctorDashboardEvent, DoctorDashboardState> {
  final GetDoctorDashboardUsecase getDoctorDashboardUsecase;
  final GetDoctorByIdUseCase getDoctorByIdUseCase;

  DoctorDashboardBloc({
    required this.getDoctorDashboardUsecase,
    required this.getDoctorByIdUseCase,
  }) : super(DoctorDashboardInitial()) {
    on<LoadDoctorDashboard>(_onLoadDoctorDashboard);
    on<LoadDoctor>(_onLoadDoctor);
  }

  Future<void> _onLoadDoctorDashboard(
    LoadDoctorDashboard event,
    Emitter<DoctorDashboardState> emit,
  ) async {
    emit(DoctorDashboardLoading());
    logger.info(
        'Loading Doctor Dashboard for UID: ${event.doctorUid} on Date: ${event.date}');

    try {
      final doctorResult = await getDoctorByIdUseCase(event.doctorUid);
      final dashboardResult =
          await getDoctorDashboardUsecase(event.doctorUid, event.date);

      final doctorData = doctorResult.fold(
        (failure) {
          logger.warning('Doctor loading failed: $failure');
          return DoctorModel(); // Default model
        },
        (doctor) => doctor,
      );

      final dashboardData = dashboardResult.fold(
        (failure) {
          logger.warning('Dashboard loading failed: $failure');
          emit(DoctorDashboardError(failure));
          return null;
        },
        (dashboard) => dashboard,
      );

      if (dashboardData != null) {
        logger.info('Emitting Dashboard Data: ${dashboardData.toString()}');
        emit(DoctorDashboardLoaded(dashboardData, doctorData));
      }
    } catch (e) {
      logger.severe('Exception during dashboard loading: $e');
      emit(DoctorDashboardError(Failure('Unexpected error occurred')));
    }
  }

  Future<void> _onLoadDoctor(
    LoadDoctor event,
    Emitter<DoctorDashboardState> emit,
  ) async {
    emit(DoctorDashboardLoading());
    final result = await getDoctorByIdUseCase(event.doctorUid);
    result.fold(
      (failure) => emit(DoctorDashboardError(failure)),
      (doctor) {
        final doctorData = DoctorModel(
          name: doctor.name,
          experience: doctor.experience,
          specialization: doctor.specialization,
          description: doctor.description,
        );
        emit(DoctorDataLoaded(doctorData));
      },
    );
  }
}
