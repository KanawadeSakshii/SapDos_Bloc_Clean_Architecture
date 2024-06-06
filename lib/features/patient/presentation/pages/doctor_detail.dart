import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/features/doctor/presentation/widgets/dropdown_bar.dart';
import 'package:bloc_project/features/patient/data/model/doctor_model.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_event.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_state.dart';
import 'package:bloc_project/features/patient/presentation/pages/doctor_details_android.dart';
import 'package:bloc_project/features/payment/pages/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorDetailsScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return DoctorDetailsAndroidState(doctor: doctor);
    }
    return BlocProvider(
      create: (context) => DoctorDetailsBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 100, right: 100),
            child: BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
              builder: (context, state) {
                final doctorDetailsBloc = context.read<DoctorDetailsBloc>();
                String? selectedTimeSlot = state.selectedTimeSlot;
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 250,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 182, 202, 236),
                                Color.fromARGB(255, 205, 198, 198),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                doctor.doctorImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 50),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.person),
                                  const SizedBox(width: 10),
                                  Text(
                                    doctor.doctorName,
                                    style: const TextStyle(
                                      color: AppPallete.gradient1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 80),
                                  RatingBarIndicator(
                                    rating: doctor.rating.toDouble(),
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text("521")
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                      Icons.assignment_turned_in_outlined),
                                  const SizedBox(width: 10),
                                  Text(
                                    doctor.doctorSpecialization,
                                    style: const TextStyle(
                                      color: AppPallete.gradient1,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.content_paste_sharp),
                                      const SizedBox(width: 10),
                                      Text(
                                        doctor.education,
                                        style: const TextStyle(
                                          color: AppPallete.gradient1,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 100),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: AppPallete.gradient4,
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.edit_document),
                                            const SizedBox(width: 10),
                                            Text(doctor.experience),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Description",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(doctor.description),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<DoctorDetailsBloc>()
                                .add(ToggleSlotExpansion());
                          },
                          child: const CustomAnimatedContainer(
                            text: 'Available Slot',
                            leadingIcon: Icons.history,
                            trailingIcon: Icons.expand_more_rounded,
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (state.isSlotExpanded)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: null,
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: doctor.timeSlots.map((timeSlot) {
                                final isSlotAvailable = true;
                                return SizedBox(
                                  width: (screenWidth - 90) / 5,
                                  child: InkWell(
                                    onTap: () {
                                      doctorDetailsBloc
                                          .add(SelectTimeSlot(timeSlot));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Radio(
                                            value: timeSlot,
                                            groupValue: selectedTimeSlot,
                                            onChanged: (value) {
                                              doctorDetailsBloc.add(
                                                  SelectTimeSlot(
                                                      value as String));
                                            },
                                          ),
                                          Container(
                                            height: 50,
                                            width: 160,
                                            decoration: BoxDecoration(
                                              color: isSlotAvailable
                                                  ? AppPallete.gradient4
                                                  : Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            child: Center(
                                              child: Text(
                                                timeSlot,
                                                style: TextStyle(
                                                  color: isSlotAvailable
                                                      ? AppPallete.gradient1
                                                      : Colors.red,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
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
                          if (doctorDetailsBloc.state.selectedTimeSlot !=
                              null) {
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
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
