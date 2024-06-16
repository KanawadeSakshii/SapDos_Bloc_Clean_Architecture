import 'package:equatable/equatable.dart';

abstract class DoctorDetailsEvent extends Equatable {
  const DoctorDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadDoctorDetails extends DoctorDetailsEvent {}

class LoadDoctorById extends DoctorDetailsEvent {
  final String doctorId;

  const LoadDoctorById(this.doctorId);

  @override
  List<Object> get props => [doctorId];
}

class SelectTimeSlot extends DoctorDetailsEvent {
  final String selectedTimeSlot;

  const SelectTimeSlot(this.selectedTimeSlot);

  @override
  List<Object> get props => [selectedTimeSlot];
}

class ToggleSlotExpansion extends DoctorDetailsEvent {}

class doctorFailure extends DoctorDetailsEvent {
  final String message;

  const doctorFailure(this.message);
}

class SelectDate extends DoctorDetailsEvent {
  final DateTime selectedDate;

  const SelectDate(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}
