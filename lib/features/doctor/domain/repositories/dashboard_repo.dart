import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_dashboard_model.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class DoctorDashboardRepository {
  Future<Either<Failure, DoctorDashboardModel>> getDoctorDashboard(
      String doctorid, String date);
  Future<Either<Failure, DoctorModel>> getDoctorByUid(String doctorUid);
}
