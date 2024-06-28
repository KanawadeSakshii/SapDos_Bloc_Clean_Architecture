part of 'doctor_details_bloc.dart';

sealed class DoctorDetailsEvent extends Equatable {
  const DoctorDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchAllDoctors extends DoctorDetailsEvent {}

class ToggleDoctorExpansion extends DoctorDetailsEvent {}

class SelectDoctor extends DoctorDetailsEvent {
  final String doctorUId;

  const SelectDoctor(this.doctorUId);

  @override
  List<Object> get props => [doctorUId];
}

class FetchDoctorDetails extends DoctorDetailsEvent {
  final String doctorUId;

  const FetchDoctorDetails(this.doctorUId);

  @override
  List<Object> get props => [doctorUId];
}

class FetchAvailableSlots extends DoctorDetailsEvent {
  final String doctorUId;
  final String date;

  FetchAvailableSlots({required this.doctorUId, required this.date});

  @override
  List<Object> get props => [doctorUId, date];
}

class SelectDate extends DoctorDetailsEvent {
  final DateTime selectedDate;

  SelectDate(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}

class SelectTimeSlot extends DoctorDetailsEvent {
  final String timeSlot;

  SelectTimeSlot(this.timeSlot);

  @override
  List<Object> get props => [timeSlot];
}

class BookAppointment extends DoctorDetailsEvent {
  final AppointmentBookingRequest request;

  BookAppointment(this.request);
}
