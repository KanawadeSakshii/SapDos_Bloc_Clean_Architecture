part of 'doctor_imports.dart'; // Import intl package for date formatting

class DoctorScreen extends StatelessWidget {
  final String uId;
  final String date; // Ensure this is in 'YYYY-MM-DD' format

  const DoctorScreen({Key? key, required this.uId, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format date if it's not in 'YYYY-MM-DD' format
    final formattedDate = _formatDate(date);

    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerWidget(),
      body: BlocProvider(
        create: (_) => serviceLocator<DoctorDashboardBloc>()
          ..add(LoadDoctorDashboard(doctorUid: uId, date: formattedDate)),
        child: BlocBuilder<DoctorDashboardBloc, DoctorDashboardState>(
          builder: (context, state) {
            if (state is DoctorDashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DoctorDashboardError) {
              return Center(child: Text('Error: ${state.error.message}'));
            } else if (state is DoctorDashboardLoaded) {
              final dashboardData = state.dashboard;
              final doctorData = state.doctorData;

              return LayoutBuilder(builder: (context, constraints) {
                bool isLargeScreen = constraints.maxWidth > 600;
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: isLargeScreen ? 400 : 30,
                      right: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Hello..!",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Name: ${doctorData.name ?? 'Unknown'}",
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
                                backgroundImage:
                                    AssetImage('assets/doctor/doctor1man.jpg'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          "Today's Appointments",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            TodaysAppointment(
                              pendingAppointment:
                                  dashboardData.pendingAppointment,
                              totalAppointment: dashboardData.totalAppointment,
                              heading: 'Pending Appointment',
                            ),
                            const SizedBox(width: 10),
                            TodaysAppointment(
                              pendingAppointment:
                                  dashboardData.completedAppointment,
                              totalAppointment: dashboardData.totalAppointment,
                              heading: 'Completed Appointment',
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        PatientAppointmentList(
                          items: dashboardData.patientList,
                        ),
                      ],
                    ),
                  ),
                );
              });
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}
