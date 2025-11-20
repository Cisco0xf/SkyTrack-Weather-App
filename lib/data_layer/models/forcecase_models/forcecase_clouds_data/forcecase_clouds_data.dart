class ForcecaseCloudsData  {
  final int cloudsAll;

  ForcecaseCloudsData({
    required this.cloudsAll,
  });

  factory ForcecaseCloudsData.fromJson({
    required Map<String, dynamic> json,
  }) {
    return ForcecaseCloudsData(
      cloudsAll: json["all"],
    );
  }
}
