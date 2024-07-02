import 'dart:convert';
import 'package:bloc_project/core/constants/constants.dart';
import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_dashboard_model.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_model.dart';
import 'package:bloc_project/features/doctor/data/models/patient_model.dart';
import 'package:bloc_project/utils/setuplogger.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';

class RemoteDataSource {
  RemoteDataSource();

  // Future<Either<Failure, dynamic>> fetchDataByRole(
  //     String role, String uId, String date) async {
  //   if (role == 'doctor') {
  //     return fetchDoctorDashboard(uId, date);
  //   } else if (role == 'patient') {
  //     return fetchPatientDetails(uId);
  //   } else {
  //     return Left(Failure('Unknown role'));
  //   }
  // }

  Future<DoctorDashboardModel> fetchDoctorDashboard(
      String doctorId, String date) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiConfig.doctorDashboard}?DoctorUId=$doctorId&Date=$date'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return DoctorDashboardModel.fromJson(jsonData);
      } else {
        logger.warning(
            'Failed to fetch doctor dashboard. Status code: ${response.statusCode}');
        throw const ServerException('Failed to fetch doctor dashboard');
      }
    } catch (e) {
      logger.severe('Exception while fetching doctor dashboard: $e');
      throw ServerException('Failed to fetch doctor dashboard');
    }
  }

  Future<Either<Failure, PatientModel>> fetchPatientDetails(
      String patientId) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiConfig.baseUrl}/Patient/GetPatientByUId?PatientUId=$patientId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null) {
          final patient = PatientModel.fromJson(data);
          return Right(patient);
        } else {
          return Left(Failure('Failed to parse patient data'));
        }
      } else {
        return Left(Failure('Failed to fetch patient details'));
      }
    } catch (e) {
      logger.severe('Exception while fetching patient details: $e');
      return Left(Failure('Failed to fetch patient details'));
    }
  }

  Future<DoctorModel> getDoctorByUid(String doctorId) async {
    final response = await http.get(
      Uri.parse(
          '${ApiConfig.baseUrl}/Doctor/GetDoctorByUId?DoctorUId=$doctorId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      logger.info('Response Doctor Data: $data');

      try {
        return DoctorModel.fromJson(data);
      } catch (e) {
        logger.severe('Failed to parse JSON into DoctorModel: $e');
        throw const ServerException('Failed to parse JSON into DoctorModel');
      }
    } else {
      logger.severe(
          'Failed to fetch doctor data. Status Code: ${response.statusCode}');
      throw const ServerException('Failed to fetch doctor data');
    }
  }

  Future<List<dynamic>> fetchAllPatients() async {
    final response = await http
        .get(Uri.parse('${ApiConfig.baseUrl}/Patient/GetAllUser?Role=patient'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      logger.severe('Fetched patients data: ${data.length} records');

      return data;
    } else {
      final errorMessage =
          'Failed to fetch patients. Status code: ${response.statusCode}';
      logger.severe(errorMessage);
      throw const ServerException('Failed to fetch patients');
    }
  }

  Future<Map<String, dynamic>> getPatientByUid(String uId) async {
    final response = await http.get(Uri.parse(
        '${ApiConfig.baseUrl}/Patient/GetPatientByUId?PatientUId=$uId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      logger.severe('Fetched patient data remote data source: $data');
      return data;
    } else {
      final errorMessage =
          'Failed to fetch patient details. Status code: ${response.statusCode}';
      logger.severe(errorMessage);
      throw ServerException(errorMessage);
    }
  }
}
