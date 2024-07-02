class ApiConfig {
  static const String baseUrl = 'https://sapdos-api-v2.azurewebsites.net/api';

  static const String login = '$baseUrl/Credentials/Login';
  static const String register = '$baseUrl/Credentials/Register';
  static const String doctorDashboard = '$baseUrl/Doctor/GetDoctorDashbord';
  static const String patientDetails = '$baseUrl/Patient/GetPatientByUId';
  static const String availableSlots = '$baseUrl/Patient/GetAvailbleSlot';
  static const String bookAppointment = '$baseUrl/Patient/BookAppointment';
}
