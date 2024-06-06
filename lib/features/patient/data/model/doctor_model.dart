import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModel {
  final String doctorName;
  final String doctorSpecialization;
  final String doctorImage;
  final double rating;
  final String education;
  final String description;
  final String experience;
  final List<String> timeSlots;

  DoctorModel({
    required this.doctorName,
    required this.doctorSpecialization,
    required this.doctorImage,
    required this.rating,
    required this.education,
    required this.description,
    required this.experience,
    required this.timeSlots,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);
}
