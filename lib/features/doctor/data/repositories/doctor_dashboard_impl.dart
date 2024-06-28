import 'package:bloc_project/core/error/exceptions.dart';
import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_model.dart';
import 'package:bloc_project/features/doctor/data/remote_datasource/doctor_remote_data_source.dart';
import 'package:bloc_project/features/doctor/domain/repositories/dashboard_repo.dart';
import 'package:fpdart/fpdart.dart';

import '../models/doctor_dashboard_model.dart';
import '../models/patient_model.dart';

class DoctorDashboardRepositoryimpl implements DoctorDashboardRepository {
  final RemoteDataSource remoteDataSource;

  DoctorDashboardRepositoryimpl(this.remoteDataSource);

  @override
  Future<Either<Failure, DoctorDashboardModel>> getDoctorDashboard(
      String doctorId, String date) async {
    try {
      final dashboard =
          await remoteDataSource.fetchDoctorDashboard(doctorId, date);
      return Right(dashboard as DoctorDashboardModel);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  Future<Either<Failure, PatientModel>> getPatientDetails(String patientId) {
    return remoteDataSource.fetchPatientDetails(patientId);
  }

  @override
  Future<Either<Failure, DoctorModel>> getDoctorByUid(String doctorUid) async {
    try {
      final doctor = await remoteDataSource.getDoctorByUid(doctorUid);
      return Right(doctor);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
