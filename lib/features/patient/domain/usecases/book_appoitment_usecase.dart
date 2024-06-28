import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/patient/data/model/appointment_book_response.dart';
import 'package:bloc_project/features/patient/data/model/appointment_booking_model.dart';
import 'package:bloc_project/features/patient/domain/repository/doctorrepo.dart';
import 'package:fpdart/fpdart.dart';

class BookAppointmentUseCase {
  final DoctorRepository repository;

  BookAppointmentUseCase(this.repository);

  Future<Either<Failure, AppointmentBookingResponse>> call(
      AppointmentBookingRequest request) async {
    return await repository.bookAppointment(request);
  }
}
