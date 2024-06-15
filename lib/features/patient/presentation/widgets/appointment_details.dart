import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_state.dart';
import 'package:flutter/material.dart';
import '../../../payment/pages/payment_screen.dart';

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
          if (state.selectedTimeSlot != null) {
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
                  "Please select a time slot.",
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
