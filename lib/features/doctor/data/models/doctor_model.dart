class DoctorModel {
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
  final String? password;
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

  DoctorModel({
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
    this.password,
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

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      address: json['address'],
      age: json['age'],
      specialization: json['specialization'],
      documents: json['documents'] is List
          ? List<String>.from(json['documents'])
          : [json['documents'].toString()],
      role: json['role'],
      description: json['description'],
      experience: json['experience'] is int
          ? json['experience']
          : int.tryParse(json['experience'] ?? ''),
      password: json['password'],
      disease: json['disease'],
      id: json['id'],
      uId: json['uId'],
      createdOn:
          json['createdOn'] != null ? DateTime.parse(json['createdOn']) : null,
      updatedOn:
          json['updatedOn'] != null ? DateTime.parse(json['updatedOn']) : null,
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      archived: json['archived'],
      version: json['version'] is int
          ? json['version']
          : int.tryParse(json['version'] ?? ''),
      active: json['active'],
      dType: json['dType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'address': address,
      'age': age,
      'specialization': specialization,
      'documents': documents,
      'role': role,
      'description': description,
      'experience': experience,
      'password': password,
      'disease': disease,
      'id': id,
      'uId': uId,
      'createdOn': createdOn?.toIso8601String(),
      'updatedOn': updatedOn?.toIso8601String(),
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'archived': archived,
      'version': version,
      'active': active,
      'dType': dType,
    };
  }
}
