import 'package:bloc_project/features/patient/domain/entity/doctor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModel {
  final String doctorUid;
  final String doctorName;
  final String doctorSpecialization;
  final String doctorImage;
  final double rating;
  final String education;
  final String description;
  final String experience;
  final List<String> timeSlots;

  DoctorModel({
    required this.doctorUid,
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
  Doctor toEntity() {
    return Doctor(
      doctorUid: doctorUid,
      name: doctorName,
      specialization: doctorSpecialization,
      image: doctorImage,
      rating: rating,
      education: education,
      description: description,
      experience: experience,
      timeSlots: timeSlots,
    );
  }

  factory DoctorModel.fromDoctor(Doctor doctor) {
    return DoctorModel(
      doctorUid: doctor.doctorUid,
      doctorName: doctor.name,
      doctorSpecialization: doctor.specialization,
      doctorImage: doctor.image,
      rating: doctor.rating,
      education: doctor.education,
      description: doctor.description,
      experience: doctor.experience,
      timeSlots: doctor.timeSlots,
    );
  }
}
