class Doctor {
  final String doctorUid;
  final String name;
  final String specialization;
  final String image;
  final double rating;
  final String education;
  final String description;
  final String experience;
  final List<String> timeSlots;

  Doctor({
    required this.doctorUid,
    required this.name,
    required this.specialization,
    required this.image,
    required this.rating,
    required this.education,
    required this.description,
    required this.experience,
    required this.timeSlots,
  });
}
