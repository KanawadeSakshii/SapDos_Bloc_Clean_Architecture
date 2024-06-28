import 'package:bloc_project/features/doctor/data/models/doctor_model.dart';
import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/patient/data/model/appointment_book_response.dart';
import 'package:bloc_project/features/patient/data/model/appointment_booking_model.dart';
import 'package:bloc_project/features/patient/data/model/available_slot_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<DoctorModel>>> getAllDoctors();
  Future<Either<Failure, List<AvailableSlotModel>>> getAvailableSlots(
      String doctorUId, String date);

  Future<Either<Failure, AppointmentBookingResponse>> bookAppointment(
      AppointmentBookingRequest request);
}
