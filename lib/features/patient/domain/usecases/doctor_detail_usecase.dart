import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/patient/domain/entity/doctor.dart';
import 'package:bloc_project/features/patient/domain/repository/doctorrepo.dart';
import 'package:fpdart/fpdart.dart';

class GetDoctorDetailsUseCase {
  final DoctorRepository repository;

  GetDoctorDetailsUseCase(this.repository);

  Future<Either<Failure, List<Doctor>>> execute() {
    return repository.getDoctors();
  }
}
