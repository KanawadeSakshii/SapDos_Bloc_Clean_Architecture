part of 'doctor_dashboard_bloc.dart';

sealed class DoctorDashboardState extends Equatable {
  const DoctorDashboardState();

  @override
  List<Object> get props => [];
}

class DoctorDashboardInitial extends DoctorDashboardState {}

class DoctorDashboardLoading extends DoctorDashboardState {}

class DoctorDashboardLoaded extends DoctorDashboardState {
  final DoctorDashboardModel dashboard;
  final DoctorModel doctorData;
  const DoctorDashboardLoaded(this.dashboard, this.doctorData);
}

class DoctorDashboardError extends DoctorDashboardState {
  final Failure error;

  const DoctorDashboardError(this.error);
  @override
  List<Object> get props => [error];
}

class DoctorDataLoaded extends DoctorDashboardState {
  final DoctorModel doctordata;

  DoctorDataLoaded(this.doctordata);
  @override
  List<Object> get props => [doctordata];
}
