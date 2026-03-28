class OriginModel {
  final String name;

  OriginModel({required this.name});

  factory OriginModel.fromJson(Map<String, dynamic> json) {
    return OriginModel(
      name: json['name'] ?? "Unknown",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}