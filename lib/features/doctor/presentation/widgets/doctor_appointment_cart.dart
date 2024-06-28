import 'package:flutter/material.dart';
import 'package:bloc_project/core/theme/app_pallete.dart';

class TodaysAppointment extends StatelessWidget {
  final int pendingAppointment;
  final int totalAppointment;
  final String heading;

  const TodaysAppointment({
    super.key,
    required this.pendingAppointment,
    required this.totalAppointment,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    double completionPercentage =
        totalAppointment != 0 ? (pendingAppointment / totalAppointment) : 0.0;

    return Container(
      decoration: BoxDecoration(
          color: AppPallete.gradient2, borderRadius: BorderRadius.circular(15)),
      width: 110,
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  value: completionPercentage,
                  backgroundColor: AppPallete.transparentColor,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppPallete.whiteColor),
                  strokeWidth: 3,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '$pendingAppointment',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppPallete.gradient1,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '/$totalAppointment',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppPallete.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              heading,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
