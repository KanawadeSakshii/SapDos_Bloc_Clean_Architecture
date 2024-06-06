import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'patientdetail_event.dart';
part 'patientdetail_state.dart';

class PatientdetailBloc extends Bloc<PatientdetailEvent, PatientdetailState> {
  bool _isHistoryExpanded = false;
  bool _isPrescriptionExpanded = false;

  PatientdetailBloc() : super(PatientdetailInitial()) {
    on<toggleHistory>((event, emit) {
      _isHistoryExpanded = !_isHistoryExpanded;
      emit(PatientdetailToggle(_isHistoryExpanded, _isPrescriptionExpanded));
    });

    on<togglePrescription>((event, emit) {
      _isPrescriptionExpanded = !_isPrescriptionExpanded;
      emit(PatientdetailToggle(_isHistoryExpanded, _isPrescriptionExpanded));
    });
  }
}
