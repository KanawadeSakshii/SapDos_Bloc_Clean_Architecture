part of 'patient_bloc_bloc.dart';

sealed class PatientBlocState extends Equatable {
  const PatientBlocState();

  @override
  List<Object> get props => [];
}

class PatientBlocInitial extends PatientBlocState {}

class AppointmentLoading extends PatientBlocState {}

final class AppointmentLoaded extends PatientBlocState {
  final List<CustomDropdownItem> appointments;

  const AppointmentLoaded(this.appointments);
  @override
  List<Object> get props => [appointments];
}

final class AppointmentError extends PatientBlocState {
  final String message;

  const AppointmentError(this.message);
  @override
  List<Object> get props => [message];
}
