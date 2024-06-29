import 'package:bloc_project/dependencies/dependescies_imports.dart';
import 'package:bloc_project/features/patient/presentation/blocs/patient_bloc/patient_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/features/doctor/data/models/patient_model.dart';

class PatientDetailsScreen extends StatelessWidget {
  final String patientUId;

  const PatientDetailsScreen({
    Key? key,
    required this.patientUId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<PatientBloc>()..add(LoadPatient(patientUId)),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<PatientBloc, PatientState>(
            builder: (context, state) {
              if (state is PatientLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PatientLoaded) {
                final patient = state.patient;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(patient),
                        const SizedBox(height: 20),
                        _buildHistorySection(context, state),
                        const SizedBox(height: 20),
                        _buildPrescriptionSection(context, state),
                      ],
                    ),
                  ),
                );
              } else if (state is PatientError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(PatientModel patient) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: 200,
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/patient/patient1hd.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${patient.name}',
                style: const TextStyle(
                  color: AppPallete.gradient1,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${patient.age} Years",
                style: const TextStyle(
                  color: AppPallete.gradient1,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Issue Description",
                style: TextStyle(
                  color: AppPallete.gradient1,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistorySection(BuildContext context, PatientLoaded state) {
    final isHistoryExpanded = state.isHistoryExpanded;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            context.read<PatientBloc>().add(ToggleHistory());
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppPallete.gradient1,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Patient History',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Icon(
                  isHistoryExpanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isHistoryExpanded ? null : 0,
          child: isHistoryExpanded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
  }

  Widget _buildPrescriptionSection(BuildContext context, PatientLoaded state) {
    final isPrescriptionExpanded = state.isPrescriptionExpanded;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            context.read<PatientBloc>().add(TogglePrescription());
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppPallete.gradient1,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Prescription',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Icon(
                  isPrescriptionExpanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isPrescriptionExpanded ? null : 0,
          child: isPrescriptionExpanded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildHistoryTile("26 March 2022"),
                    const SizedBox(height: 8),
                    _buildHistoryTile("13 April 2022"),
                    const SizedBox(height: 8),
                    _buildHistoryTile("Add new", trailingIcon: Icons.add),
                  ],
                )
              : Container(),
        ),
      ],
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
        trailing: Icon(
          trailingIcon ?? Icons.remove_red_eye_rounded,
          color: AppPallete.gradient1,
        ),
      ),
    );
  }
}
