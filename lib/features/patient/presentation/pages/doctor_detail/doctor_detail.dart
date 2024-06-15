part of 'doctor_details_imports.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

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
                    const SizedBox(height: 40),
                    const SizedBox(height: 20),
                    AvailableSlotsWidget(
                      doctorDetailsBloc: doctorDetailsBloc,
                      state: state,
                      screenWidth: MediaQuery.of(context).size.width,
                      doctor: doctor,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: BookAppointmentButton(
                        doctorDetailsBloc: doctorDetailsBloc,
                        state: state,
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
