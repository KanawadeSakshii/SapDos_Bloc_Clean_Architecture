class AppointmentBookingResponse {
  final String id;
  final bool booked;
  final bool treated;
  final String slotDate;
  final String slotTime;
  final String patientUid;
  final String doctorUid;
  final String dType;
  final String? prescriptionText;

  AppointmentBookingResponse({
    required this.id,
    required this.booked,
    required this.treated,
    required this.slotDate,
    required this.slotTime,
    required this.patientUid,
    required this.doctorUid,
    required this.dType,
    this.prescriptionText,
  });

  factory AppointmentBookingResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentBookingResponse(
      id: json['id'],
      booked: json['booked'],
      treated: json['treated'],
      slotDate: json['slotDate'],
      slotTime: json['slotTime'],
      patientUid: json['patientUid'],
      doctorUid: json['doctorUid'],
      dType: json['dType'],
      prescriptionText: json['prescriptionText'],
    );
  }
}
