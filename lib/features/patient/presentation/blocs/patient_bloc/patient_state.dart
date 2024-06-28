part of 'patient_bloc.dart';

sealed class PatientState extends Equatable {
  const PatientState();

  @override
  List<Object> get props => [];
}

final class PatientInitial extends PatientState {}

class PatientLoading extends PatientState {}

class PatientLoaded extends PatientState {
  final PatientModel patient;
  final bool isHistoryExpanded;
  final bool isPrescriptionExpanded;
  const PatientLoaded({
    required this.patient,
    this.isHistoryExpanded = false,
    this.isPrescriptionExpanded = false,
  });
  PatientLoaded copyWith({
    PatientModel? patient,
    bool? isHistoryExpanded,
    bool? isPrescriptionExpanded,
  }) {
    return PatientLoaded(
      patient: patient ?? this.patient,
      isHistoryExpanded: isHistoryExpanded ?? this.isHistoryExpanded,
      isPrescriptionExpanded:
          isPrescriptionExpanded ?? this.isPrescriptionExpanded,
    );
  }

  @override
  List<Object> get props =>
      [patient, isHistoryExpanded, isPrescriptionExpanded];
}

class PatientError extends PatientState {
  final String message;

  const PatientError(this.message);

  @override
  List<Object> get props => [message];
}
