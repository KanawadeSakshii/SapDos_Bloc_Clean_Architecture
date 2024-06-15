// To parse this JSON data, do
//
//     final AppointmentModel = AppointmentModelFromJson(jsonString);

import 'dart:convert';

AppointmentModel appointmentModelFromJson(String str) =>
    AppointmentModel.fromJson(json.decode(str));

String appointmentModelToJson(AppointmentModel data) =>
    json.encode(data.toJson());

class AppointmentModel {
  String patientUId;
  String doctorUId;
  String appointmentDate;
  String appointmentTime;

  AppointmentModel({
    required this.patientUId,
    required this.doctorUId,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        patientUId: json["patientUId"],
        doctorUId: json["doctorUId"],
        appointmentDate: json["appointmentDate"],
        appointmentTime: json["appointmentTime"],
      );

  Map<String, dynamic> toJson() => {
        "patientUId": patientUId,
        "doctorUId": doctorUId,
        "appointmentDate": appointmentDate,
        "appointmentTime": appointmentTime,
      };
}
