import 'dart:convert';
import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/patient/data/model/doctor_model.dart';
import 'package:bloc_project/features/patient/domain/entity/doctor.dart';
import 'package:bloc_project/features/patient/domain/repository/doctorrepo.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fpdart/fpdart.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  @override
  Future<Either<Failure, List<Doctor>>> getDoctors() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/doctor.json');
      final List<dynamic> data = json.decode(response);
      final List<DoctorModel> doctorModels =
          data.map((json) => DoctorModel.fromJson(json)).toList();

      final List<Doctor> doctors =
          doctorModels.map((model) => model.toEntity()).toList();

      return Right(doctors);
    } catch (e) {
      return Left(Failure("Not load"));
    }
  }

  @override
  Future<Either<Failure, Doctor>> getDoctorById(String doctorId) async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/doctor.json');
      final List<dynamic> data = json.decode(response);
      final List<DoctorModel> doctorModels =
          data.map((json) => DoctorModel.fromJson(json)).toList();

      final DoctorModel doctorModel =
          doctorModels.firstWhere((doctor) => doctor.doctorUid == doctorId);

      return Right(doctorModel.toEntity());
    } catch (e) {
      return Left(Failure("Not load"));
    }
  }
}
