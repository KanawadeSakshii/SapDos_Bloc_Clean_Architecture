part of 'patient_imports.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<DoctorDetailsBloc>()..add(LoadDoctorDetails()),
      child: Scaffold(
        appBar: AppBar(),
        drawer: const DrawerWidget(),
        body: BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
          builder: (context, state) {
            if (state.doctors.isEmpty) {
              return const Loader();
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                bool isLargeScreen = constraints.maxWidth > 500;

                return SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: isLargeScreen ? 400 : 30,
                          right: isLargeScreen ? 100 : 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Hello..!",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "  Mr. Satish",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/patient/patient2man.jpg'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          InkWell(
                            onTap: () {
                              context
                                  .read<DoctorDetailsBloc>()
                                  .add(ToggleSlotExpansion());
                            },
                            child: const CustomAnimatedContainer(
                              text: "Doctors's List",
                              trailingIcon: Icons.filter_alt_sharp,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          if (state.isSlotExpanded)
                            Center(
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: isLargeScreen ? 2 : 1,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 30,
                                  childAspectRatio: 3,
                                ),
                                itemCount: state.doctors.length,
                                itemBuilder: (context, index) {
                                  final doctor = state.doctors[index];
                                  return GestureDetector(
                                    onTap: () {
                                      context.go(
                                          '/patient/doctor/${doctor.doctorUid}');
                                    },
                                    child: DoctorDetailsCart(
                                      doctorName: doctor.doctorName,
                                      doctorSpecialization:
                                          doctor.doctorSpecialization,
                                      doctorImage: doctor.doctorImage,
                                      rating: doctor.rating,
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
