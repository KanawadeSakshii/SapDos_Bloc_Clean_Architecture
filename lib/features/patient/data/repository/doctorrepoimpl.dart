import 'package:bloc_project/core/error/exceptions.dart';
import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_model.dart';
import 'package:bloc_project/features/patient/data/datasource_patient/remote_data_source_patient.dart';
import 'package:bloc_project/features/patient/data/model/appointment_book_response.dart';
import 'package:bloc_project/features/patient/data/model/appointment_booking_model.dart';
import 'package:bloc_project/features/patient/data/model/available_slot_model.dart';
import 'package:bloc_project/features/patient/domain/repository/doctorrepo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:bloc_project/utils/setuplogger.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final RemoteDataSourcePatient remoteDataSourcePatient;

  DoctorRepositoryImpl({required this.remoteDataSourcePatient});

  @override
  Future<Either<Failure, List<DoctorModel>>> getAllDoctors() async {
    logger.info('Calling remote data source to fetch all doctors');
    final result = await remoteDataSourcePatient.getAllDoctors();
    result.fold(
      (failure) => logger.severe('Error in repository: ${failure.message}'),
      (doctors) =>
          logger.info('Fetched ${doctors.length} doctors in repository'),
    );
    return result;
  }

  @override
  Future<Either<Failure, List<AvailableSlotModel>>> getAvailableSlots(
      String doctorUId, String date) async {
    logger.info('Calling remote data source to fetch available slots');
    try {
      final result =
          await remoteDataSourcePatient.fetchAvailableSlots(doctorUId, date);
      result.fold(
        (failure) => logger.severe('Error in repository: ${failure.message}'),
        (slots) => logger
            .info('Fetched ${slots.length} available slots in repository'),
      );
      return result;
    } catch (e) {
      logger.severe('Exception occurred in repository: $e');
      return Left(Failure('Exception occurred in repository: $e'));
    }
  }

  @override
  Future<Either<Failure, AppointmentBookingResponse>> bookAppointment(
      AppointmentBookingRequest request) async {
    try {
      final response = await remoteDataSourcePatient.bookAppointment(request);
      return Right(response);
    } on ServerException {
      return Left(Failure("Fail to post appointment"));
    }
  }
}
