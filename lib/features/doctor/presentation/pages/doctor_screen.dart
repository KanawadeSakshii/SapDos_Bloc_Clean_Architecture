import 'package:bloc_project/core/common/widget/drawer_widget.dart';
import 'package:bloc_project/features/doctor/presentation/blocs/patient/bloc/patient_bloc_bloc.dart';
import 'package:bloc_project/features/doctor/presentation/widgets/doctor_appointment_cart.dart';
import 'package:bloc_project/features/doctor/presentation/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorScreen extends StatelessWidget {
  static const routeName = '/doctor';
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (builder) => const DoctorScreen());
  const DoctorScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerWidget(),
      body: BlocProvider(
        create: (context) => PatientBlocBloc()..add(LoadAppointments()),
        child: LayoutBuilder(builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 600;
          return SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(left: isLargeScreen ? 400 : 30, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        children: [
                          Text(
                            "Hello..!",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Dr. Amol",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/doctor/doctor1man.jpg'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Today's Appointments",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      TodaysAppointment(
                        tasks: 15,
                        totalTasks: 40,
                        heading: 'Pending Appointment',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TodaysAppointment(
                        tasks: 35,
                        totalTasks: 40,
                        heading: 'Pending Appointment',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<PatientBlocBloc, PatientBlocState>(
                      builder: (context, state) {
                    if (state is AppointmentLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is AppointmentLoaded) {
                      return CustomDropdownWidget(
                        items: state.appointments,
                      );
                    } else if (state is AppointmentError) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return Container();
                  })
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
