part of 'doctor_details_imports.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final String doctorUId;
  final String? date;
  final String patientUId;
  const DoctorDetailsScreen({
    Key? key,
    required this.doctorUId,
    this.date,
    required this.patientUId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorDetailsBloc(
        getAllDoctorsUseCase: serviceLocator<GetAllDoctorsUseCase>(),
        getDoctorByIdUseCase: serviceLocator<GetDoctorByIdUseCase>(),
        getAvailableSlotsUseCase: serviceLocator<GetAvailableSlotsUseCase>(),
        bookAppointmentUseCase: serviceLocator<BookAppointmentUseCase>(),
      )..add(FetchDoctorDetails(doctorUId)),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
          builder: (context, state) {
            if (state is DoctorDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DoctorDetailsError) {
              return const Center(
                  child: const Text('Could Not Fetch Your Data'));
            } else if (state is DoctorDetailsLoaded) {
              final DoctorModel doctorModel =
                  state.selectedDoctor ?? DoctorModel();
              final List<AvailableSlotModel>? availableSlots =
                  state.availableSlots;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            height: 200,
                            width: 250,
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
                                  'assets/doctor/doctor4men.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.person),
                                    const SizedBox(width: 10),
                                    Text(
                                      doctorModel.name ?? '',
                                      style: const TextStyle(
                                        color: AppPallete.gradient1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const Spacer(),
                                    RatingBarIndicator(
                                      itemBuilder: (context, index) =>
                                          const Icon(
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
                                    const Icon(
                                        Icons.assignment_turned_in_outlined),
                                    const SizedBox(width: 10),
                                    Text(
                                      doctorModel.specialization ?? '',
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
                                        const Text(
                                          // doctorModel.description ?? '',
                                          'MBBS, PHD',
                                          style: TextStyle(
                                            color: AppPallete.gradient1,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(width: 150),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppPallete.gradient4,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.edit_document),
                                              const SizedBox(width: 5),
                                              Text(
                                                  '${doctorModel.experience} Years'
                                                      .toString()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Description",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(doctorModel.description ?? ''),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      AvailableSlotsWidget(
                        doctorUId: doctorUId,
                        date: date ??
                            DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        doctorDetailsBloc: context.read<DoctorDetailsBloc>(),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: BookAppointmentButton(
                          state: state,
                          patientUId: patientUId,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
