import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/patient/domain/entity/doctor.dart';
import 'package:fpdart/fpdart.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<Doctor>>> getDoctors();
  Future<Either<Failure, Doctor>> getDoctorById(String doctorId);
}
