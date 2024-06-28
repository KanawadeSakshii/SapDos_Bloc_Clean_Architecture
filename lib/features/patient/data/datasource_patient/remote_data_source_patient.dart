import 'dart:convert';
import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_model.dart';
import 'package:bloc_project/features/patient/data/model/appointment_book_response.dart';
import 'package:bloc_project/features/patient/data/model/appointment_booking_model.dart';
import 'package:bloc_project/features/patient/data/model/available_slot_model.dart';
import 'package:bloc_project/utils/setuplogger.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';

class RemoteDataSourcePatient {
  final String baseUrl;

  RemoteDataSourcePatient(this.baseUrl);

  Future<Either<Failure, List<DoctorModel>>> getAllDoctors() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/Patient/GetAllUser?Role=doctor'));

      logger
          .info('HTTP GET request to: $baseUrl/Patient/GetAllUser?Role=doctor');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final doctors = data.map((json) => DoctorModel.fromJson(json)).toList();

        logger.info('Fetched ${doctors.length} doctors');
        return Right(doctors);
      } else {
        logger.severe(
            'Failed to fetch doctors. Status code: ${response.statusCode}');
        return Left(Failure(
            'Failed to fetch doctors. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      logger.severe('Exception occurred while fetching doctors: $e');
      return Left(Failure('Exception occurred while fetching doctors: $e'));
    }
  }

  Future<Either<Failure, List<AvailableSlotModel>>> fetchAvailableSlots(
      String doctorUId, String date) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/Patient/GetAvailbleSlot?DoctorUId=$doctorUId&Date=$date'),
      );

      logger.info(
          'API request URL: $baseUrl/Patient/GetAvailbleSlot?DoctorUId=$doctorUId&Date=$date');

      if (response.statusCode == 200) {
        final List<dynamic> slotsJson = jsonDecode(response.body);
        logger.info('Received slots JSON: $slotsJson');

        final List<AvailableSlotModel> slots =
            slotsJson.map((json) => AvailableSlotModel.fromJson(json)).toList();

        return Right(slots);
      } else {
        logger.severe(
            'Failed to load available slots. Status code: ${response.statusCode}');
        return Left(Failure(
            'Failed to load available slots. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      logger.severe('Exception occurred while fetching available slots: $e');
      return Left(
          Failure('Exception occurred while fetching available slots: $e'));
    }
  }

  Future<AppointmentBookingResponse> bookAppointment(
      AppointmentBookingRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Patient/BookAppointment'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return AppointmentBookingResponse.fromJson(json.decode(response.body));
    } else {
      throw Failure("Remote data sourece patient; book appointment");
    }
  }
}
