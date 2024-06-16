import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/patient/domain/entity/doctor.dart';
import 'package:bloc_project/features/patient/domain/repository/doctorrepo.dart';
import 'package:fpdart/fpdart.dart';

class GetDoctorByIdUseCase {
  final DoctorRepository repository;

  GetDoctorByIdUseCase(this.repository);

  Future<Either<Failure, Doctor>> execute(String doctorId) {
    return repository.getDoctorById(doctorId);
  }
}
