import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_model.dart';
import 'package:bloc_project/features/patient/domain/repository/doctorrepo.dart';
import 'package:fpdart/fpdart.dart';

class GetAllDoctorsUseCase {
  final DoctorRepository repository;

  GetAllDoctorsUseCase({required this.repository});

  Future<Either<Failure, List<DoctorModel>>> call() async {
    return repository.getAllDoctors();
  }
}
