import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/patient/data/model/available_slot_model.dart';
import 'package:bloc_project/features/patient/domain/repository/doctorrepo.dart';
import 'package:fpdart/fpdart.dart';

class GetAvailableSlotsUseCase {
  final DoctorRepository repository;

  GetAvailableSlotsUseCase(this.repository);

  Future<Either<Failure, List<AvailableSlotModel>>> call(
      String doctorUId, String date) {
    return repository.getAvailableSlots(doctorUId, date);
  }
}
