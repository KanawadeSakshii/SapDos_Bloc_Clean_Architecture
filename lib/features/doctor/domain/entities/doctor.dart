import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String id;
  final String name;
  final String specialization;
  final String photo;
  final double rating;
  final String education;
  final int experience;
  final String description;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.photo,
    required this.rating,
    required this.education,
    required this.experience,
    required this.description,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
