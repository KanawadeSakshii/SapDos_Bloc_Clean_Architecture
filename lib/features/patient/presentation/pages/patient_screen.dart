import 'package:bloc_project/core/common/widget/drawer_widget.dart';
import 'package:bloc_project/core/common/widget/loader.dart';
import 'package:bloc_project/features/doctor/presentation/widgets/dropdown_bar.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_event.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_bloc/bloc/doctor_state.dart';
import 'package:bloc_project/features/patient/presentation/pages/doctor_detail.dart';
import 'package:bloc_project/features/patient/presentation/widgets/doctor_details_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorDetailsBloc()..add(LoadDoctorDetails()),
      child: Scaffold(
        appBar: AppBar(),
        drawer: const DrawerWidget(),
        body: BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
          builder: (context, state) {
            if (state.doctor.isEmpty) {
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
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
                              Container(
                                height: 100,
                                width: 100,
                                child: const CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/doctor/doctor1man.jpg'),
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
                                itemCount: state.doctor.length,
                                itemBuilder: (context, index) {
                                  final doctor = state.doctor[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorDetailsScreen(
                                            doctor: doctor,
                                          ),
                                        ),
                                      );
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