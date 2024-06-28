// part of 'patientdetail_bloc.dart';

// sealed class PatientdetailState extends Equatable {
//   const PatientdetailState();

//   @override
//   List<Object> get props => [];
// }

// final class PatientdetailInitial extends PatientdetailState {}

// class PatientDetailLoading extends PatientdetailState {}

// class PatientDetailLoaded extends PatientdetailState {
//   final PatientModel patient;

//   const PatientDetailLoaded({required this.patient});

//   @override
//   List<Object> get props => [patient];
// }

// class PatientdetailHistoryLoaded extends PatientdetailState {
//   final List<PatientHistory> history;

//   PatientdetailHistoryLoaded({required this.history});
// }

// class PatientdetailPrescriptionsLoaded extends PatientdetailState {
//   final List<Prescription> prescriptions;

//   PatientdetailPrescriptionsLoaded({required this.prescriptions});
// }

// final class PatientdetailToggle extends PatientdetailState {
//   final bool isHistoryExpended;
//   final bool isPrescriptionExpanded;

//   PatientdetailToggle(this.isHistoryExpended, this.isPrescriptionExpanded);
//   @override
//   List<Object> get props => [isHistoryExpended, isPrescriptionExpanded];
// }

// class PatientDetailError extends PatientdetailState {
//   final String message;

//   PatientDetailError({required this.message});

//   @override
//   List<Object> get props => [message];
// }
