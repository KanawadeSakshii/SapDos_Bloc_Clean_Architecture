part of 'common_imports.dart';

class BookAppointmentButton extends StatelessWidget {
  final DoctorDetailsState state;
  final String patientUId;

  const BookAppointmentButton({
    Key? key,
    required this.state,
    required this.patientUId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppPallete.gradient1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () {
          if (state is DoctorDetailsLoaded) {
            final loadedState = state as DoctorDetailsLoaded;
            final selectedDoctor = loadedState.selectedDoctor;
            final selectedTimeSlot = loadedState.selectedTimeSlot;
            final selectedDate = loadedState.selectedDate;

            if (selectedDoctor != null &&
                selectedTimeSlot != null &&
                selectedDate != null) {
              final appointmentRequest = AppointmentBookingRequest(
                patientUId: patientUId,
                doctorUId: '${selectedDoctor.uId}',
                appointmentDate: DateFormat('yyyy-MM-dd').format(selectedDate),
                appointmentTime: selectedTimeSlot, // Ensure this is a String
              );
              logger.info('Booking appointment with the following details:');
              logger.info('Patient UID: $patientUId');
              logger.info('Doctor UID: ${selectedDoctor.uId}');
              logger.info(
                  'Appointment Date: ${appointmentRequest.appointmentDate}');
              logger.info(
                  'Appointment Time: ${appointmentRequest.appointmentTime}');
              context
                  .read<DoctorDetailsBloc>()
                  .add(BookAppointment(appointmentRequest));

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Please select a time slot and date",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Please select a doctor first",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          }
        },
        child: const Text(
          "Book Appointment",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
