import 'package:bloc_project/features/doctor/domain/entities/appointment_data.dart';
import 'package:bloc_project/features/doctor/presentation/blocs/dropdown/bloc/dropdown_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_project/core/theme/app_pallete.dart';

import '../pages/patient/patient_imports.dart';

class CustomDropdownWidget extends StatelessWidget {
  final List<CustomDropdownItem> items;

  const CustomDropdownWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  Color _getColorForStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppPallete.gradient1;
      case 'cancel':
        return AppPallete.errorColor;
      case 'pending':
        return AppPallete.succesColor;
      default:
        return AppPallete.greyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DropdownBloc(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          bool isTablet = maxWidth > 600;
          bool isDesktop = maxWidth > 1024;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<DropdownBloc>().add(ToggleDropdown());
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppPallete.gradient1,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedDefaultTextStyle(
                        style: TextStyle(
                          color: AppPallete.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: isTablet ? 16 : 14,
                        ),
                        duration: const Duration(milliseconds: 300),
                        child: const Text("March, 7 Sunday"),
                      ),
                      Icon(
                        Icons.calendar_month,
                        color: AppPallete.whiteColor,
                        size: isTablet ? 24 : 22,
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<DropdownBloc, DropdownState>(
                builder: (context, state) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: state is DropdownExpanded ? null : 0,
                    child: ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: state is DropdownExpanded ? 1.0 : 0.0,
                        child: Column(
                          children: items.map((item) {
                            Color statusColor = _getColorForStatus(item.status);
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PatientDetailsScreen(),
                                  ),
                                );
                              },
                              leading: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: AppPallete.gradient4,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  item.icon,
                                  color: statusColor,
                                  size: isTablet ? 28 : 24,
                                ),
                              ),
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: isTablet ? 150 : 100,
                                    decoration: BoxDecoration(
                                      color: AppPallete.gradient4,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 12),
                                    child: Text(
                                      item.time,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: AppPallete.gradient1,
                                        fontSize: isTablet ? 16 : 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Container(
                                    width: isDesktop
                                        ? 200
                                        : isTablet
                                            ? maxWidth * 0.5
                                            : maxWidth * 0.4,
                                    decoration: BoxDecoration(
                                      color: AppPallete.transparentColor,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: statusColor),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item.name,
                                          style: TextStyle(
                                            color: AppPallete.gradient1,
                                            fontSize: isTablet ? 16 : 12,
                                          ),
                                        ),
                                        Text(
                                          '${item.age} Years',
                                          style: TextStyle(
                                            color: AppPallete.gradient1,
                                            fontSize: isTablet ? 16 : 12,
                                          ),
                                        ),
                                        if (item.status.toLowerCase() ==
                                            'completed')
                                          const Icon(
                                            Icons.check_circle,
                                            color: Color.fromARGB(
                                                255, 196, 195, 195),
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
