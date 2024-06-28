class PatientEntity {
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

  const PatientEntity({
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
}
