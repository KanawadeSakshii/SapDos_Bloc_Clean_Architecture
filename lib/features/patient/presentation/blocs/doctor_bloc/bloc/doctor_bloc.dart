import 'package:bloc/bloc.dart';
import 'package:bloc_project/features/patient/data/model/doctor_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'doctor_event.dart';
import 'doctor_state.dart';

class DoctorDetailsBloc extends Bloc<DoctorDetailsEvent, DoctorDetailsState> {
  DoctorDetailsBloc()
      : super(DoctorDetailsState(
          doctor: [],
        )) {
    on<LoadDoctorDetails>(_onLoadDoctorDetails);
    on<SelectTimeSlot>(_onSelectTimeSlot);
    on<ToggleSlotExpansion>(_onToggleSlotExpansion);
  }

  Future<void> _onLoadDoctorDetails(
      LoadDoctorDetails event, Emitter<DoctorDetailsState> emit) async {
    final String response =
        await rootBundle.loadString('assets/json/doctor.json');
    final List<dynamic> data = json.decode(response);
    final List<DoctorModel> doctor =
        data.map((json) => DoctorModel.fromJson(json)).toList();
    ;

    emit(DoctorDetailsState(
        doctor: doctor, isSlotExpanded: state.isSlotExpanded));
  }

  void _onSelectTimeSlot(
      SelectTimeSlot event, Emitter<DoctorDetailsState> emit) {
    emit(state.copyWith(selectedTimeSlot: event.selectedTimeSlot));
  }

  void _onToggleSlotExpansion(
      ToggleSlotExpansion event, Emitter<DoctorDetailsState> emit) {
    emit(state.copyWith(isSlotExpanded: !state.isSlotExpanded));
  }
}
