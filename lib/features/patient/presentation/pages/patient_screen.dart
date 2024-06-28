part of 'patient_imports.dart';

class PatientScreen extends StatelessWidget {
  final String uId;

  const PatientScreen({Key? key, required this.uId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<PatientBloc>()..add(LoadPatient(uId)),
      child: Scaffold(
        appBar: AppBar(),
        drawer: const DrawerWidget(),
        body: BlocListener<DoctorDetailsBloc, DoctorDetailsState>(
          listener: (context, state) {
            if (state is NavigateToDoctorDetails) {
              Navigator.pushNamed(
                context,
                '/doctorDetails',
                arguments: state.doctorUId,
              );
            }
          },
          child: BlocBuilder<PatientBloc, PatientState>(
            builder: (context, state) {
              if (state is PatientLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PatientLoaded) {
                final patient = state.patient;
                return BlocProvider(
                  create: (_) => serviceLocator<DoctorDetailsBloc>()
                    ..add(FetchAllDoctors()),
                  child: BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
                    builder: (context, doctorState) {
                      if (doctorState is DoctorDetailsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (doctorState is DoctorDetailsLoaded) {
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            bool isLargeScreen = constraints.maxWidth > 500;

                            return SingleChildScrollView(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isLargeScreen ? 300 : 30,
                                    vertical: 30,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Hello..!",
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${patient.name}',
                                                style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                'assets/patient/patient2man.jpg',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 25),
                                      const CustomAnimatedContainer(
                                        text: "Doctors's List",
                                        trailingIcon: Icons.filter_alt_sharp,
                                      ),
                                      const SizedBox(height: 25),
                                      if (doctorState.isExpanded)
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                isLargeScreen ? 2 : 1,
                                            crossAxisSpacing: 30,
                                            mainAxisSpacing: 30,
                                            childAspectRatio: 3,
                                          ),
                                          itemCount: doctorState.doctors.length,
                                          itemBuilder: (context, index) {
                                            final doctor =
                                                doctorState.doctors[index];
                                            return GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<DoctorDetailsBloc>()
                                                    .add(SelectDoctor(
                                                        '${doctor.uId}'));
                                                context.go(
                                                    '/patient/${patient.uId}/doctor_details/${doctor.uId}/${patient.uId}');
                                              },
                                              child: DoctorDetailsCart(
                                                doctorModel: doctor,
                                              ),
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (doctorState is DoctorDetailsError) {
                        return Center(
                          child: Text(
                            'Error: ${doctorState.message}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
