class AvailableSlotModel {
  final String time;
  final bool isAvailable;

  AvailableSlotModel({
    required this.time,
    required this.isAvailable,
  });

  factory AvailableSlotModel.fromJson(Map<String, dynamic> json) {
    return AvailableSlotModel(
      time: json['time'],
      isAvailable: json['isAvailable'],
    );
  }
}
