part of 'patientdetail_bloc.dart';

sealed class PatientdetailEvent extends Equatable {
  const PatientdetailEvent();

  @override
  List<Object> get props => [];
}

class toggleHistory extends PatientdetailEvent {}

class togglePrescription extends PatientdetailEvent {}
