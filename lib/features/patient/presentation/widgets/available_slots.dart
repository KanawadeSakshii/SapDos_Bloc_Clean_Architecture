part of 'common_imports.dart';

class AvailableSlotsWidget extends StatelessWidget {
  final DoctorDetailsBloc doctorDetailsBloc;
  final String doctorUId;
  final String date;

  const AvailableSlotsWidget({
    Key? key,
    required this.doctorUId,
    required this.date,
    required this.doctorDetailsBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
      bloc: doctorDetailsBloc,
      builder: (context, state) {
        if (state is DoctorDetailsLoaded) {
          logger.info('Displaying available slots');
          return Column(
            children: [
              InkWell(
                onTap: () {
                  doctorDetailsBloc.add(ToggleDoctorExpansion());
                },
                child: CustomAnimatedContainer(
                  text: 'Available Slot',
                  leadingIcon: Icons.history,
                  trailingIcon: Icons.calendar_today_outlined,
                  onTrailingIconTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd')
                          .format(pickedDate); // Ensure correct formatting
                      logger.info('Selected date: $formattedDate');
                      doctorDetailsBloc.add(FetchAvailableSlots(
                        doctorUId: doctorUId,
                        date: formattedDate,
                      ));
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              if (state.isSlotExpanded && state.availableSlots != null)
                LayoutBuilder(builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth;
                  int columns = screenWidth < 500 ? 2 : 4;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: state.availableSlots!.map((timeSlot) {
                        return SizedBox(
                          width: (screenWidth - (columns + 1) * 10) / columns,
                          child: InkWell(
                            onTap: () {
                              doctorDetailsBloc
                                  .add(SelectTimeSlot(timeSlot.time));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  value: timeSlot.time,
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
                                      timeSlot.time,
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
                  );
                }),
            ],
          );
        }
        logger.info('No available slots to display');
        return Container();
      },
    );
  }
}
