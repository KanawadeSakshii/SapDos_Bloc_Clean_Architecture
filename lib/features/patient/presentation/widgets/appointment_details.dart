part of 'common_imports.dart';

class BookAppointmentButton extends StatelessWidget {
  final DoctorDetailsBloc doctorDetailsBloc;
  final DoctorDetailsState state;

  const BookAppointmentButton({
    super.key,
    required this.doctorDetailsBloc,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppPallete.gradient1,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: AppPallete.whiteColor,
          backgroundColor: AppPallete.gradient1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () {
          if (state.selectedTimeSlot != null && state.selectedDate != null) {
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
                  "Please select a time slot & Date",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          }
        },
        child: const Text("Book Appointment"),
      ),
    );
  }
}
