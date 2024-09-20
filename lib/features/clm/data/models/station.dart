class Station {
  final int id;
  final String shortName;
  final String fullName;

  Station({required this.id, required this.shortName, required this.fullName});

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'],
      shortName: json['short_name'],
      fullName: json['full_name'],
    );
  }
}
