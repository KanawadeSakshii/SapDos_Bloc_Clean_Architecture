part of 'doctor_details_bloc.dart';

sealed class DoctorDetailsState extends Equatable {
  const DoctorDetailsState();

  @override
  List<Object?> get props => [];
}

final class DoctorDetailsInitial extends DoctorDetailsState {}

final class DoctorDetailsLoading extends DoctorDetailsState {}

class DoctorDetailsLoaded extends DoctorDetailsState {
  final List<DoctorModel> doctors;
  final bool isExpanded;
  final DoctorModel? selectedDoctor;
  final List<AvailableSlotModel>? availableSlots;
  final String? selectedTimeSlot;
  final DateTime? selectedDate;
  final bool isSlotExpanded;

  DoctorDetailsLoaded({
    required this.doctors,
    required this.isExpanded,
    this.selectedDoctor,
    this.availableSlots,
    this.selectedDate,
    this.selectedTimeSlot,
    required this.isSlotExpanded,
  });

  @override
  List<Object?> get props => [
        doctors,
        isExpanded,
        selectedDoctor,
        availableSlots,
        selectedTimeSlot,
        selectedDate,
        isSlotExpanded,
      ];

  DoctorDetailsLoaded copyWith({
    List<DoctorModel>? doctors,
    bool? isExpanded,
    DoctorModel? selectedDoctor,
    List<AvailableSlotModel>? availableSlots,
    String? selectedTimeSlot,
    DateTime? selectedDate,
    bool? isSlotExpanded,
  }) {
    return DoctorDetailsLoaded(
      doctors: doctors ?? this.doctors,
      isExpanded: isExpanded ?? this.isExpanded,
      selectedDoctor: selectedDoctor ?? this.selectedDoctor,
      availableSlots: availableSlots ?? this.availableSlots,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      selectedDate: selectedDate ?? this.selectedDate,
      isSlotExpanded: isSlotExpanded ?? this.isSlotExpanded,
    );
  }
}

final class DoctorDetailsError extends DoctorDetailsState {
  final String message;

  const DoctorDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

class NavigateToDoctorDetails extends DoctorDetailsState {
  final String doctorUId;

  const NavigateToDoctorDetails(this.doctorUId);

  @override
  List<Object> get props => [doctorUId];
}

class AppointmentBookingSuccess extends DoctorDetailsState {
  final AppointmentBookingResponse response;

  AppointmentBookingSuccess(this.response);
}

class AppointmentBookingError extends DoctorDetailsState {
  final String message;

  AppointmentBookingError(this.message);
}
