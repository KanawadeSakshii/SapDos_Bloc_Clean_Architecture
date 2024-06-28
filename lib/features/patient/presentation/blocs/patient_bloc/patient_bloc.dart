import 'package:bloc/bloc.dart';
import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/patient_model.dart';
import 'package:bloc_project/features/doctor/domain/Usecase/get_patient_appointment_usecase.dart';
import 'package:bloc_project/utils/setuplogger.dart';
import 'package:equatable/equatable.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final GetPatientByIdUseCase getPatientByUidUseCase;

  PatientBloc(this.getPatientByUidUseCase) : super(PatientInitial()) {
    on<LoadPatient>(_onLoadPatient);
    on<ToggleHistory>(_mapToggleHistoryToState);
    on<TogglePrescription>(_mapTogglePrescriptionToState);
  }

  void _onLoadPatient(LoadPatient event, Emitter<PatientState> emit) async {
    emit(PatientLoading());
    try {
      logger.severe('Fetching patient with ID: ${event.uId}');
      final eitherResult = await getPatientByUidUseCase(event.uId);
      eitherResult.fold(
        (failure) {
          logger.severe('Error fetching patient: ${failure.message}');
          emit(PatientError(_mapFailureToMessage(failure)));
        },
        (patient) {
          if (patient != null) {
            logger.severe('Fetched patient: ${patient.name}');
            emit(PatientLoaded(patient: patient));
          } else {
            emit(PatientError('Patient data is null'));
          }
        },
      );
    } catch (e) {
      logger.severe('Unexpected error: ${e.toString()}');
      emit(PatientError('Unexpected error occurred'));
    }
  }

  void _mapToggleHistoryToState(
      ToggleHistory event, Emitter<PatientState> emit) {
    if (state is PatientLoaded) {
      final currentState = state as PatientLoaded;
      emit(currentState.copyWith(
        isHistoryExpanded: !currentState.isHistoryExpanded,
      ));
    }
  }

  void _mapTogglePrescriptionToState(
      TogglePrescription event, Emitter<PatientState> emit) {
    if (state is PatientLoaded) {
      final currentState = state as PatientLoaded;
      emit(currentState.copyWith(
          isPrescriptionExpanded: !currentState.isPrescriptionExpanded));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message ?? 'Unknown error occurred';
  }
}
