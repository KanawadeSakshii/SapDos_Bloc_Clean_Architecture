class AvailableSlot {
  final String doctorId;
  final String time;
  final bool isBooked;

  const AvailableSlot({
    required this.doctorId,
    required this.time,
    this.isBooked = false,
  });
}
