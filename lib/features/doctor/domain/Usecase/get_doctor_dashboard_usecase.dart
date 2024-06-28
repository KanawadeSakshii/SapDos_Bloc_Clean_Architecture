import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_dashboard_model.dart';
import 'package:bloc_project/features/doctor/data/repositories/doctor_dashboard_impl.dart';
import 'package:fpdart/fpdart.dart';

class GetDoctorDashboardUsecase {
  final DoctorDashboardRepositoryimpl repository;

  GetDoctorDashboardUsecase(this.repository);

  Future<Either<Failure, DoctorDashboardModel>> call(
      String doctorId, String date) {
    return repository.getDoctorDashboard(doctorId, date);
  }
}
