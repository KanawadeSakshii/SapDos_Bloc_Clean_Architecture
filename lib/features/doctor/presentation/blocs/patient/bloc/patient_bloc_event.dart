part of 'patient_bloc_bloc.dart';

sealed class PatientBlocEvent extends Equatable {
  const PatientBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadAppointments extends PatientBlocEvent {}
