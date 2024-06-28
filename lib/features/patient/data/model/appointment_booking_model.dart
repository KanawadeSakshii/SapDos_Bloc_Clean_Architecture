class AppointmentBookingRequest {
  final String patientUId;
  final String doctorUId;
  final String appointmentDate;
  final String appointmentTime;

  AppointmentBookingRequest({
    required this.patientUId,
    required this.doctorUId,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  Map<String, dynamic> toJson() => {
        "patientUId": patientUId,
        "doctorUId": doctorUId,
        "appointmentDate": appointmentDate,
        "appointmentTime": appointmentTime,
      };
}
