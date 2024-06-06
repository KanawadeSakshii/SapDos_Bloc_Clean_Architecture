import 'package:bloc/bloc.dart';
import 'package:bloc_project/features/doctor/domain/entities/appointment_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'patient_bloc_event.dart';
part 'patient_bloc_state.dart';

class PatientBlocBloc extends Bloc<PatientBlocEvent, PatientBlocState> {
  PatientBlocBloc() : super(PatientBlocInitial()) {
    on<LoadAppointments>((event, emit) async {
      emit(AppointmentLoading());
      await Future.delayed(Duration(seconds: 2));
      final appointments = [
        CustomDropdownItem(
          icon: Icons.person,
          name: "John Doe",
          age: 30,
          time: "10:00 AM",
          status: "Completed",
          issueDescription: '',
        ),
        CustomDropdownItem(
          icon: Icons.person,
          name: "Jane Smith",
          age: 25,
          time: "11:00 AM",
          status: "Pending",
          issueDescription: '',
        ),
        CustomDropdownItem(
          icon: Icons.person,
          name: "David Brown",
          age: 40,
          time: "12:00 PM",
          status: "Cancel",
          issueDescription: '',
        ),
      ];
      emit(AppointmentLoaded(appointments));
    });
  }
}
