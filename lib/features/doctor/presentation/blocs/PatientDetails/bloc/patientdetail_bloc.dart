// import 'package:bloc_project/features/doctor/data/models/patient_history.dart';
// import 'package:bloc_project/features/doctor/data/models/patient_model.dart';
// import 'package:bloc_project/features/doctor/data/models/patient_prescription.dart';
// import 'package:bloc_project/features/doctor/domain/repositories/patient_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'patientdetail_event.dart';
// part 'patientdetail_state.dart';

// class PatientdetailBloc extends Bloc<PatientdetailEvent, PatientdetailState> {
//   final PatientRepository repository;

//   bool _isHistoryExpanded = false;
//   bool _isPrescriptionExpanded = false;

//   PatientdetailBloc(this.repository) : super(PatientdetailInitial()) {
//     on<FetchPatientDetails>((event, emit) async {
//       emit(PatientDetailLoading());
//       try {
//         final patient = await repository.fetchPatientDetails(event.patientUId);
//         emit(PatientDetailLoaded(patient: patient));
//       } catch (e) {
//         emit(PatientDetailError(message: e.toString()));
//       }
//     });

//     on<ToggleHistory>((event, emit) async {
//       _isHistoryExpanded = !_isHistoryExpanded;
//       if (_isHistoryExpanded) {
//         emit(PatientDetailLoading());
//         try {
//           final history =
//               await repository.fetchPatientHistory(event.patientUid);
//           emit(PatientdetailHistoryLoaded(history: history));
//         } catch (e) {
//           emit(PatientDetailError(message: e.toString()));
//         }
//       }
//       emit(PatientdetailToggle(_isHistoryExpanded, _isPrescriptionExpanded));
//     });

//     on<TogglePrescription>((event, emit) async {
//       _isPrescriptionExpanded = !_isPrescriptionExpanded;
//       if (_isPrescriptionExpanded) {
//         emit(PatientDetailLoading());
//         try {
//           final prescriptions =
//               await repository.fetchPrescriptions(event.patientUid);
//           emit(PatientdetailPrescriptionsLoaded(prescriptions: prescriptions));
//         } catch (e) {
//           emit(PatientDetailError(message: e.toString()));
//         }
//       }
//       emit(PatientdetailToggle(_isHistoryExpanded, _isPrescriptionExpanded));
//     });
//   }
// }
