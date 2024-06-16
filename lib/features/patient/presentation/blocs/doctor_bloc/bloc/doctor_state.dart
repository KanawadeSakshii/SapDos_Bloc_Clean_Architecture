import 'package:bloc_project/features/patient/data/model/doctor_model.dart';
import 'package:bloc_project/features/patient/domain/entity/doctor.dart';
import 'package:equatable/equatable.dart';

class DoctorDetailsState extends Equatable {
  final List<DoctorModel> doctors;
  final Doctor? selectedDoctor;

  final String? selectedTimeSlot;
  final bool isSlotExpanded;
  final DateTime? selectedDate;
  final String? error;

  const DoctorDetailsState({
    required this.doctors,
    this.selectedDoctor,
    this.selectedTimeSlot,
    this.isSlotExpanded = false,
    this.selectedDate,
    this.error,
  });

  DoctorDetailsState copyWith({
    List<DoctorModel>? doctors,
    Doctor? selectedDoctor,
    String? selectedTimeSlot,
    bool? isSlotExpanded,
    DateTime? selectedDate,
    String? error,
  }) {
    return DoctorDetailsState(
      doctors: doctors ?? this.doctors,
      selectedDoctor: selectedDoctor ?? this.selectedDoctor,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      isSlotExpanded: isSlotExpanded ?? this.isSlotExpanded,
      selectedDate: selectedDate ?? this.selectedDate,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        doctors,
        selectedDoctor,
        selectedDate,
        selectedTimeSlot,
        isSlotExpanded,
        error
      ];
}
