class Substation {
  final int id;
  final String shortName;
  final String fullName;

  Substation({
    required this.id,
    required this.shortName,
    required this.fullName,
  });

  factory Substation.fromJson(Map<String, dynamic> json) {
    return Substation(
      id: json['id'],
      shortName: json['short_name'],
      fullName: json['full_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'short_name': shortName,
      'full_name': fullName,
    };
  }
}
