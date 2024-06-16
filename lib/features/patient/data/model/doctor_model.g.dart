// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
      doctorUid: json['doctorUid'] as String,
      doctorName: json['doctorName'] as String,
      doctorSpecialization: json['doctorSpecialization'] as String,
      doctorImage: json['doctorImage'] as String,
      rating: (json['rating'] as num).toDouble(),
      education: json['education'] as String,
      description: json['description'] as String,
      experience: json['experience'] as String,
      timeSlots:
          (json['timeSlots'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'doctorUid': instance.doctorUid,
      'doctorName': instance.doctorName,
      'doctorSpecialization': instance.doctorSpecialization,
      'doctorImage': instance.doctorImage,
      'rating': instance.rating,
      'education': instance.education,
      'description': instance.description,
      'experience': instance.experience,
      'timeSlots': instance.timeSlots,
    };
