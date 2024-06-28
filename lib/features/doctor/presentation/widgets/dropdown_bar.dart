import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/features/patient/presentation/blocs/doctor_details/bloc/doctor_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAnimatedContainer extends StatelessWidget {
  final String text;
  final IconData? leadingIcon;
  final IconData trailingIcon;
  final VoidCallback? onTrailingIconTap;
  const CustomAnimatedContainer({
    Key? key,
    required this.text,
    this.leadingIcon,
    required this.trailingIcon,
    this.onTrailingIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
      builder: (context, state) {
        final isExpanded = state is DoctorDetailsLoaded && state.isExpanded;
        return AnimatedContainer(
          height: isExpanded ? 60 : 45,
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppPallete.gradient1,
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () {
              context.read<DoctorDetailsBloc>().add(ToggleDoctorExpansion());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      leadingIcon ?? Icons.person,
                      color: Colors.white,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    AnimatedDefaultTextStyle(
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      duration: const Duration(milliseconds: 300),
                      child: Text(text),
                    ),
                  ],
                ),
                IconButton(
                  onPressed:
                      onTrailingIconTap, // Optional: handle trailing icon tap if needed
                  icon: Icon(
                    trailingIcon,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
