import 'package:bloc/bloc.dart';
import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/patient/data/model/doctor_model.dart';
import 'package:bloc_project/features/patient/domain/entity/doctor.dart';
import 'package:bloc_project/features/patient/domain/usecases/doctor_detail_usecase.dart';
import 'package:bloc_project/features/patient/domain/usecases/get_doctor_by_id_use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'doctor_event.dart';
import 'doctor_state.dart';

class DoctorDetailsBloc extends Bloc<DoctorDetailsEvent, DoctorDetailsState> {
  final GetDoctorDetailsUseCase getDoctorDetailsUseCase;
  final GetDoctorByIdUseCase getDoctorByIdUseCase;

  DoctorDetailsBloc(this.getDoctorDetailsUseCase, this.getDoctorByIdUseCase)
      : super(const DoctorDetailsState(
          doctors: [],
        )) {
    on<LoadDoctorDetails>(_onLoadDoctorDetails);
    on<SelectTimeSlot>(_onSelectTimeSlot);
    on<ToggleSlotExpansion>(_onToggleSlotExpansion);
    on<LoadDoctorById>(_onLoadDoctorById);
    on<SelectDate>((event, emit) {
      emit(state.copyWith(selectedDate: event.selectedDate));
    });
  }

  Future<void> _onLoadDoctorDetails(
      LoadDoctorDetails event, Emitter<DoctorDetailsState> emit) async {
    final result = await getDoctorDetailsUseCase.execute();

    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (doctors) => emit(state.copyWith(
        doctors:
            doctors.map((doctor) => DoctorModel.fromDoctor(doctor)).toList(),
        isSlotExpanded: state.isSlotExpanded,
      )),
    );
  }

  Future<void> _onLoadDoctorById(
      LoadDoctorById event, Emitter<DoctorDetailsState> emit) async {
    final Either<Failure, Doctor> result =
        await getDoctorByIdUseCase.execute(event.doctorId);

    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (doctor) => emit(state.copyWith(
        selectedDoctor: doctor,
        error: null,
      )),
    );
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
