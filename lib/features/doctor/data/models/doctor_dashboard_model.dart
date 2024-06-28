import 'package:bloc_project/features/doctor/data/models/appintment_model.dart';

class DoctorDashboardModel {
  final int pendingAppointment;
  final int completedAppointment;
  final int totalAppointment;
  final List<AppointmentModel> patientList;

  DoctorDashboardModel({
    required this.pendingAppointment,
    required this.completedAppointment,
    required this.totalAppointment,
    required this.patientList,
  });

  factory DoctorDashboardModel.fromJson(Map<String, dynamic> json) {
    return DoctorDashboardModel(
      pendingAppointment: json['pendingAppointment'] ?? 0,
      completedAppointment: json['completedAppointment'] ?? 0,
      totalAppointment: json['totalAppointment'] ?? 0,
      patientList: (json['patientList'] as List<dynamic>? ?? [])
          .map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
