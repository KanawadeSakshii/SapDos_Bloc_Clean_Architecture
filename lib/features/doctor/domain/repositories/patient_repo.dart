// features/doctor/domain/repositories/patient_repository.dart

import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/patient_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class PatientRepository {
  Future<Either<Failure, List<PatientModel>>> getAllPatients();
  Future<Either<Failure, PatientModel>> getPatientByUid(String uId);
}
