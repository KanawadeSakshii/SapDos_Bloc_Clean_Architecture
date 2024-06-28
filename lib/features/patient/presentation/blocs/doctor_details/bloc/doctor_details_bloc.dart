import 'package:bloc/bloc.dart';
import 'package:bloc_project/core/error/failure.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_model.dart';
import 'package:bloc_project/features/doctor/domain/Usecase/get_doctor_usecase.dart';
import 'package:bloc_project/features/patient/data/model/appointment_book_response.dart';
import 'package:bloc_project/features/patient/data/model/appointment_booking_model.dart';
import 'package:bloc_project/features/patient/data/model/available_slot_model.dart';
import 'package:bloc_project/features/patient/domain/usecases/book_appoitment_usecase.dart';
import 'package:bloc_project/features/patient/domain/usecases/get_all_doctor_usecase.dart';
import 'package:bloc_project/features/patient/domain/usecases/get_available_slots_usecase.dart';
import 'package:bloc_project/utils/setuplogger.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'doctor_details_event.dart';
part 'doctor_details_state.dart';

class DoctorDetailsBloc extends Bloc<DoctorDetailsEvent, DoctorDetailsState> {
  final GetAllDoctorsUseCase getAllDoctorsUseCase;
  final GetDoctorByIdUseCase getDoctorByIdUseCase;
  final GetAvailableSlotsUseCase getAvailableSlotsUseCase;
  final BookAppointmentUseCase bookAppointmentUseCase;
  DoctorDetailsBloc({
    required this.getAvailableSlotsUseCase,
    required this.getAllDoctorsUseCase,
    required this.getDoctorByIdUseCase,
    required this.bookAppointmentUseCase,
  }) : super(DoctorDetailsInitial()) {
    on<FetchAllDoctors>(_onFetchDoctors);
    on<ToggleDoctorExpansion>(_onToggleDoctorExpansion);
    on<SelectDoctor>(_onSelectDoctor);
    on<FetchDoctorDetails>(_onFetchDoctorDetails);
    on<FetchAvailableSlots>(_onFetchAvailableSlots);
    on<SelectDate>(_onSelectDate);
    on<SelectTimeSlot>(_onSelectTimeSlot);
    on<BookAppointment>(_onBookAppointment);
  }

  void _onFetchDoctors(
      FetchAllDoctors event, Emitter<DoctorDetailsState> emit) async {
    emit(DoctorDetailsLoading());

    final result = await getAllDoctorsUseCase();
    result.fold(
      (failure) {
        logger.severe('Error fetching doctors: ${failure.message}');
        emit(DoctorDetailsError(_mapFailureToMessage(failure)));
      },
      (doctors) {
        logger.info('Fetched ${doctors.length} doctors');
        emit(DoctorDetailsLoaded(
          isExpanded: false,
          doctors: doctors,
          isSlotExpanded: true,
        ));
      },
    );
  }

  void _onFetchDoctorDetails(
      FetchDoctorDetails event, Emitter<DoctorDetailsState> emit) async {
    emit(DoctorDetailsLoading());

    final result = await getDoctorByIdUseCase(event.doctorUId);
    result.fold(
      (failure) {
        logger.severe('Error fetching doctor details: ${failure.message}');
        emit(DoctorDetailsError(_mapFailureToMessage(failure)));
      },
      (doctor) {
        logger.info('Fetched doctor details for ${doctor.id}');
        emit(DoctorDetailsLoaded(
          isExpanded: false,
          doctors: [doctor],
          selectedDoctor: doctor,
          isSlotExpanded: true,
        ));
      },
    );
  }

  void _onToggleDoctorExpansion(
      ToggleDoctorExpansion event, Emitter<DoctorDetailsState> emit) {
    if (state is DoctorDetailsLoaded) {
      final currentState = state as DoctorDetailsLoaded;
      emit(currentState.copyWith(isExpanded: !currentState.isExpanded));
    }
  }

  void _onSelectDoctor(SelectDoctor event, Emitter<DoctorDetailsState> emit) {
    emit(NavigateToDoctorDetails(event.doctorUId));
  }

  void _onFetchAvailableSlots(
      FetchAvailableSlots event, Emitter<DoctorDetailsState> emit) async {
    final currentState = state;
    if (currentState is DoctorDetailsLoaded) {
      try {
        logger.info(
            'Fetching available slots for date: ${event.date}'); // Log the date
        final result =
            await getAvailableSlotsUseCase(event.doctorUId, event.date);
        result.fold(
          (failure) {
            logger.severe('Error fetching available slots: ${failure.message}');
            emit(DoctorDetailsError(_mapFailureToMessage(failure)));
          },
          (slots) {
            logger.info('Fetched ${slots.length} available slots');
            emit(currentState.copyWith(
              availableSlots: slots,
              selectedDate: DateTime.parse(event.date), // Parse the date
              isSlotExpanded: true,
            ));
          },
        );
      } catch (e) {
        logger.severe('Exception occurred while fetching available slots: $e');
        emit(DoctorDetailsError(
            'Exception occurred while fetching available slots: $e'));
      }
    }
  }

  DateTime _parseDate(String dateString) {
    final now = DateTime.now();
    final dayOfMonth = int.tryParse(dateString) ?? now.day;
    return DateTime(now.year, now.month, dayOfMonth);
  }

  void _onSelectDate(SelectDate event, Emitter<DoctorDetailsState> emit) {
    if (state is DoctorDetailsLoaded) {
      final currentState = state as DoctorDetailsLoaded;
      emit(currentState.copyWith(selectedDate: event.selectedDate));
    }
  }

  void _onSelectTimeSlot(
      SelectTimeSlot event, Emitter<DoctorDetailsState> emit) {
    if (state is DoctorDetailsLoaded) {
      final currentState = state as DoctorDetailsLoaded;
      emit(currentState.copyWith(selectedTimeSlot: event.timeSlot));
    }
  }

  void _onBookAppointment(
      BookAppointment event, Emitter<DoctorDetailsState> emit) async {
    emit(DoctorDetailsLoading());
    final result = await bookAppointmentUseCase(event.request);
    result.fold(
      (failure) {
        logger.severe('Failed to book appointment: ${failure.message}');
        emit(AppointmentBookingError("Failed to book appointment"));
      },
      (response) {
        logger.info('Appointment booked successfully');
        emit(AppointmentBookingSuccess(response));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}
