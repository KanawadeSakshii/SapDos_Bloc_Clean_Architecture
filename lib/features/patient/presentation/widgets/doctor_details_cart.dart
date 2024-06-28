import 'package:flutter/material.dart';
import 'package:bloc_project/features/doctor/data/models/doctor_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DoctorDetailsCart extends StatelessWidget {
  final DoctorModel doctorModel;

  const DoctorDetailsCart({
    Key? key,
    required this.doctorModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/doctor/doctor7man.jpg'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${doctorModel.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  '${doctorModel.specialization}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      itemBuilder: (context, index) {
                        return index < 3
                            ? const Icon(
                                Icons.star,
                                color: Colors.amber,
                              )
                            : const Icon(
                                Icons.star,
                                color: Colors.grey,
                              );
                      },
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                      rating: 521,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      "512",
                      // rating.toStringAsFixed(
                      //     1),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
