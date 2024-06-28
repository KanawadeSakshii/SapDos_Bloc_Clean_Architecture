import 'package:bloc_project/features/doctor/data/models/appintment_model.dart';

class DoctorDashboard {
  final int pendingAppointment;
  final int completedAppointment;
  final int totalAppointment;
  final List<AppointmentModel> patientList;

  DoctorDashboard({
    required this.pendingAppointment,
    required this.completedAppointment,
    required this.totalAppointment,
    required this.patientList,
  });
}
