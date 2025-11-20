class ForcecaseWindData {
  final double speed;
  final int degree;

  ForcecaseWindData({
    required this.speed,
    required this.degree,
  });

  factory ForcecaseWindData.fromJson({
    required Map<String, dynamic> json,
  }) {
    return ForcecaseWindData(
      speed: (json["speed"] is int) ? json["speed"].toDouble() : json["speed"],
      degree: json["deg"],
    );
  }
}
