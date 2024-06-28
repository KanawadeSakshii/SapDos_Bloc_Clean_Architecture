// features/doctor/data/repositories/patient_repository_impl.dart

import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/patient_model.dart';
import 'package:bloc_project/features/doctor/data/remote_datasource/doctor_remote_data_source.dart';
import 'package:bloc_project/features/doctor/domain/repositories/patient_repo.dart';
import 'package:fpdart/fpdart.dart';

class PatientRepositoryImpl implements PatientRepository {
  final RemoteDataSource remoteDataSource;

  PatientRepositoryImpl({required this.remoteDataSource});

  Future<Either<Failure, List<PatientModel>>> getAllPatients() async {
    try {
      final response = await remoteDataSource.fetchAllPatients();
      final patients = response
          .map<PatientModel>(
              (json) => PatientModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return Right(patients);
    } catch (e) {
      return Left(Failure('Failed to fetch patients: $e'));
    }
  }

  Future<Either<Failure, PatientModel>> getPatientByUid(String uId) async {
    try {
      final response = await remoteDataSource.getPatientByUid(uId);
      if (response != null) {
        final patient = PatientModel.fromJson(response);
        return Right(patient);
      } else {
        return Left(Failure('Patient data is null'));
      }
    } catch (e) {
      return Left(Failure('Failed to fetch patient details: $e'));
    }
  }
}
