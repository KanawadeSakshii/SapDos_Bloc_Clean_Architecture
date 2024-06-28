class AppointmentModel {
  final String slotUId;
  final String patientUId;
  final String name;
  final String slotTime;
  final bool treated;

  AppointmentModel({
    required this.slotUId,
    required this.patientUId,
    required this.name,
    required this.slotTime,
    required this.treated,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      slotUId: json['slotUId'] ?? '',
      patientUId: json['patientUId'] ?? '',
      name: json['name'] ?? '',
      slotTime: json['slotTime'] ?? '',
      treated: json['treated'] ?? false,
    );
  }
}
