part of 'doctor_dashboard_bloc.dart';

sealed class DoctorDashboardEvent extends Equatable {
  const DoctorDashboardEvent();

  @override
  List<Object> get props => [];
}

class LoadDoctorDashboard extends DoctorDashboardEvent {
  final String doctorUid;
  final String date;

  const LoadDoctorDashboard({required this.doctorUid, required this.date});
}

class LoadDoctor extends DoctorDashboardEvent {
  final String doctorUid;

  const LoadDoctor({required this.doctorUid});

  @override
  List<Object> get props => [doctorUid];
}
