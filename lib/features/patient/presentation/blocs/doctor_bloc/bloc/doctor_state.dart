import 'package:bloc_project/features/patient/data/model/doctor_model.dart';
import 'package:equatable/equatable.dart';

class DoctorDetailsState extends Equatable {
  final List<DoctorModel> doctor;
  final String? selectedTimeSlot;
  final bool isSlotExpanded;

  const DoctorDetailsState({
    required this.doctor,
    this.selectedTimeSlot,
    this.isSlotExpanded = false,
  });

  DoctorDetailsState copyWith({
    List<DoctorModel>? doctor,
    String? selectedTimeSlot,
    bool? isSlotExpanded,
  }) {
    return DoctorDetailsState(
      doctor: doctor ?? this.doctor,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      isSlotExpanded: isSlotExpanded ?? this.isSlotExpanded,
    );
  }

  @override
  List<Object?> get props => [doctor, selectedTimeSlot, isSlotExpanded];
}
