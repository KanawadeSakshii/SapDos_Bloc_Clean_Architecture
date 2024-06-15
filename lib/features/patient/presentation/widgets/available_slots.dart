import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/features/doctor/presentation/widgets/dropdown_bar.dart';
import 'package:bloc_project/features/patient/data/model/doctor_model.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_event.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_state.dart';
import 'package:flutter/material.dart';

class AvailableSlotsWidget extends StatelessWidget {
  final DoctorDetailsBloc doctorDetailsBloc;
  final DoctorDetailsState state;
  final double screenWidth;
  final DoctorModel doctor;

  const AvailableSlotsWidget({
    super.key,
    required this.doctorDetailsBloc,
    required this.state,
    required this.screenWidth,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            doctorDetailsBloc.add(ToggleSlotExpansion());
          },
          child: CustomAnimatedContainer(
            text: 'Available Slot',
            leadingIcon: Icons.history,
            trailingIcon: Icons.calendar_month_outlined,
            onTrailingIconTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                print('Picked Date: $pickedDate');
              }
            },
          ),
        ),
        const SizedBox(height: 20),
        if (state.isSlotExpanded)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: doctor.timeSlots.map((timeSlot) {
                return SizedBox(
                  width: (screenWidth - 90) / 2,
                  child: InkWell(
                    onTap: () {
                      doctorDetailsBloc.add(SelectTimeSlot(timeSlot));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: timeSlot,
                          groupValue: state.selectedTimeSlot,
                          onChanged: (value) {
                            doctorDetailsBloc
                                .add(SelectTimeSlot(value as String));
                          },
                        ),
                        Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: AppPallete.gradient4,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Center(
                            child: Text(
                              timeSlot,
                              style: const TextStyle(
                                color: AppPallete.gradient1,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
