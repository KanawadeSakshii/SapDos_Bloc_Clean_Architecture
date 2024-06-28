import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/patient_model.dart';
import 'package:bloc_project/features/doctor/data/repositories/patient_repo_impl.dart';
import 'package:bloc_project/features/doctor/domain/repositories/patient_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetPatientByIdUseCase {
  final PatientRepository repository;

  GetPatientByIdUseCase({required this.repository});

  Future<Either<Failure, PatientModel>> call(String patientId) async {
    return await repository.getPatientByUid(patientId);
  }
}
