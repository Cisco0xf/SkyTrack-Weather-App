class LonLatData {
  final double longtude;
  final double latitude;

  LonLatData({
    required this.latitude,
    required this.longtude,
  });

  factory LonLatData.fromJson({
    required Map<String, dynamic> json,
  }) {
    return LonLatData(
      latitude: json["lon"],
      longtude: json["lat"],
    );
  }
}
