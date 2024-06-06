import 'dart:convert';

import 'package:bloc_project/features/patient/data/model/doctor_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class DoctorRepository {
  Future<List<DoctorModel>> getDoctors() async {
    final jsonText = await rootBundle.loadString('assets/assets/doctors.json');
    final List<dynamic> doctorsJson = json.decode(jsonText);
    return doctorsJson.map((json) => DoctorModel.fromJson(json)).toList();
  }
}
