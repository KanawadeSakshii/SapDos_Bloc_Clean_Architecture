import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/features/doctor/presentation/blocs/PatientDetails/bloc/patientdetail_bloc.dart';
import 'package:bloc_project/features/doctor/presentation/pages/patient_details_android.dart';
import 'package:bloc_project/features/doctor/presentation/widgets/dropdown_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientDetailsScreen extends StatelessWidget {
  const PatientDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return PatientDetailsAndroid();
    }
    return BlocProvider(
      create: (_) => PatientdetailBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: Column(
            children: [
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
                          'assets/patient/patient1hd.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 10),
                              Text(
                                "John",
                                style: TextStyle(
                                  color: AppPallete.gradient1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.accessibility_sharp),
                              SizedBox(width: 10),
                              Text(
                                "30 Years",
                                style: TextStyle(
                                  color: AppPallete.gradient1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Issue Description",
                                style: TextStyle(
                                  color: AppPallete.gradient1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  BlocBuilder<PatientdetailBloc, PatientdetailState>(
                    builder: (context, state) {
                      bool isHistoryExpanded = false;
                      if (state is PatientdetailToggle) {
                        isHistoryExpanded = state.isHistoryExpended;
                      }
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              context
                                  .read<PatientdetailBloc>()
                                  .add(toggleHistory());
                            },
                            child: CustomAnimatedContainer(
                              text: 'Patient History',
                              leadingIcon: Icons.history,
                              trailingIcon: isHistoryExpanded
                                  ? Icons.expand_less_rounded
                                  : Icons.expand_more_rounded,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: isHistoryExpanded ? null : 0,
                            child: isHistoryExpanded
                                ? Column(
                                    children: [
                                      const SizedBox(height: 8),
                                      _buildHistoryTile("Blood Report"),
                                      const SizedBox(height: 8),
                                      _buildHistoryTile("CT Scan report"),
                                    ],
                                  )
                                : Container(),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<PatientdetailBloc, PatientdetailState>(
                  builder: (context, state) {
                    bool isPrescriptionExpanded = false;

                    if (state is PatientdetailToggle) {
                      isPrescriptionExpanded = state.isPrescriptionExpanded;
                    }

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<PatientdetailBloc>()
                                .add(togglePrescription());
                          },
                          child: CustomAnimatedContainer(
                            text: 'Prescription',
                            leadingIcon: Icons.edit_document,
                            trailingIcon: isPrescriptionExpanded
                                ? Icons.expand_less_rounded
                                : Icons.expand_more_rounded,
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: isPrescriptionExpanded ? null : 0,
                          child: isPrescriptionExpanded
                              ? Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    _buildHistoryTile("26 March 2022"),
                                    const SizedBox(height: 8),
                                    _buildHistoryTile("13 April 2022"),
                                    const SizedBox(height: 8),
                                    _buildHistoryTile("Add new",
                                        trailingIcon: Icons.add),
                                  ],
                                )
                              : Container(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryTile(String data, {IconData? trailingIcon}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppPallete.gradient1),
      ),
      child: ListTile(
        leading: Text(data),
        trailing: Icon(trailingIcon ?? Icons.remove_red_eye_rounded,
            color: AppPallete.gradient1),
      ),
    );
  }
}
