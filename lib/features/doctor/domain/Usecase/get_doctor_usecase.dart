import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_model.dart';
import 'package:bloc_project/features/doctor/domain/repositories/dashboard_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetDoctorByIdUseCase {
  final DoctorDashboardRepository repository;

  GetDoctorByIdUseCase(this.repository);

  Future<Either<Failure, DoctorModel>> call(String doctorUid) async {
    return repository.getDoctorByUid(doctorUid);
  }
}
