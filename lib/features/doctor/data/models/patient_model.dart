import 'package:equatable/equatable.dart';

class PatientModel extends Equatable {
  final String? name;
  final String? email;
  final String? mobileNumber;
  final String? address;
  final String? age;
  final String? specialization;
  final List<String>? documents;
  final String? role;
  final String? description;
  final int? experience;
  final String? disease;
  final String? id;
  final String? uId;
  final DateTime? createdOn;
  final DateTime? updatedOn;
  final String? createdBy;
  final String? updatedBy;
  final bool? archived;
  final int? version;
  final bool? active;
  final String? dType;

  const PatientModel({
    this.name,
    this.email,
    this.mobileNumber,
    this.address,
    this.age,
    this.specialization,
    this.documents,
    this.role,
    this.description,
    this.experience,
    this.disease,
    this.id,
    this.uId,
    this.createdOn,
    this.updatedOn,
    this.createdBy,
    this.updatedBy,
    this.archived,
    this.version,
    this.active,
    this.dType,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        name: json['name'],
        email: json['email'],
        mobileNumber: json['mobileNumber'],
        address: json['address'],
        age: json['age'],
        specialization: json['specialization'],
        documents: json['documents'] != null
            ? List<String>.from(json['documents'])
            : [],
        role: json['role'],
        description: json['description'],
        experience: json['experience'],
        disease: json['disease'],
        id: json['id'],
        uId: json['uId'],
        createdOn: json['createdOn'] != null
            ? DateTime.parse(json['createdOn'])
            : null,
        updatedOn: json['updatedOn'] != null
            ? DateTime.parse(json['updatedOn'])
            : null,
        createdBy: json['createdBy'],
        updatedBy: json['updatedBy'],
        archived: json['archived'],
        version: json['version'],
        active: json['active'],
        dType: json['dType'],
      );

  @override
  List<Object?> get props => [id];
}
