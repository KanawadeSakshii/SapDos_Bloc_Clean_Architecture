import 'package:equatable/equatable.dart';

abstract class DoctorDetailsEvent extends Equatable {
  const DoctorDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadDoctorDetails extends DoctorDetailsEvent {}

class SelectTimeSlot extends DoctorDetailsEvent {
  final String selectedTimeSlot;

  const SelectTimeSlot(this.selectedTimeSlot);

  @override
  List<Object> get props => [selectedTimeSlot];
}

class ToggleSlotExpansion extends DoctorDetailsEvent {}

class doctorFailure extends DoctorDetailsEvent {
  final String message;

  doctorFailure(this.message);
}
