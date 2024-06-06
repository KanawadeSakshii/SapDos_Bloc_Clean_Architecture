part of 'patientdetail_bloc.dart';

sealed class PatientdetailState extends Equatable {
  const PatientdetailState();

  @override
  List<Object> get props => [];
}

final class PatientdetailInitial extends PatientdetailState {}

final class PatientdetailToggle extends PatientdetailState {
  final bool isHistoryExpended;
  final bool isPrescriptionExpanded;

  PatientdetailToggle(this.isHistoryExpended, this.isPrescriptionExpanded);
  @override
  List<Object> get props => [isHistoryExpended, isPrescriptionExpanded];
}
