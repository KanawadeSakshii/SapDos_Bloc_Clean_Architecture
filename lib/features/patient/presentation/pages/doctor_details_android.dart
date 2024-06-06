import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/features/doctor/presentation/widgets/dropdown_bar.dart';
import 'package:bloc_project/features/patient/data/model/doctor_model.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_event.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_state.dart';
import 'package:bloc_project/features/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DoctorDetailsAndroidState extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorDetailsAndroidState({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final isAndroid = Theme.of(context).platform == TargetPlatform.android;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => DoctorDetailsBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
            builder: (context, state) {
              final doctorDetailsBloc = context.read<DoctorDetailsBloc>();
              String? selectedTimeSlot = state.selectedTimeSlot;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(doctor.doctorImage),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                              rating: doctor.rating,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(width: 10),
                            const Text("521"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.assignment_turned_in_outlined),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(doctor.description),
                          ],
                        ),
                        const SizedBox(height: 40),
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
                              SingleChildScrollView(
                                child: Expanded(
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    child: Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      alignment: WrapAlignment.spaceBetween,
                                      children:
                                          doctor.timeSlots.map((timeSlot) {
                                        const isSlotAvailable = true;
                                        return SizedBox(
                                          width: (screenWidth -
                                                  (isAndroid ? 70 : 90)) /
                                              (isAndroid ? 2 : 2),
                                          child: InkWell(
                                            onTap: () {
                                              doctorDetailsBloc.add(
                                                  SelectTimeSlot(timeSlot));
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(3),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Radio(
                                                    value: timeSlot,
                                                    groupValue:
                                                        selectedTimeSlot,
                                                    onChanged: (value) {
                                                      doctorDetailsBloc.add(
                                                          SelectTimeSlot(
                                                              value as String));
                                                    },
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    width: 130,
                                                    decoration: BoxDecoration(
                                                      color: isSlotAvailable
                                                          ? AppPallete.gradient4
                                                          : Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        timeSlot,
                                                        style: const TextStyle(
                                                          color: isSlotAvailable
                                                              ? AppPallete
                                                                  .gradient1
                                                              : Colors.red,
                                                          fontWeight:
                                                              FontWeight.normal,
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
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
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
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}