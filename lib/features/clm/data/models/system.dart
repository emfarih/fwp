class System {
  final int id;
  final String shortName;
  final String fullName;

  System({
    required this.id,
    required this.shortName,
    required this.fullName,
  });

  factory System.fromJson(Map<String, dynamic> json) {
    return System(
      id: json['id'],
      shortName: json['short_name'],
      fullName: json['full_name'],
    );
  }
}
