part of 'patient_bloc.dart';

sealed class PatientEvent extends Equatable {
  const PatientEvent();

  @override
  List<Object> get props => [];
}

class LoadPatient extends PatientEvent {
  final String uId;

  const LoadPatient(this.uId);

  @override
  List<Object> get props => [uId];
}

class ToggleHistory extends PatientEvent {}

class TogglePrescription extends PatientEvent {}
