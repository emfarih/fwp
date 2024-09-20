class LocationType {
  final int id;
  final String name;

  LocationType({required this.id, required this.name});

  factory LocationType.fromJson(Map<String, dynamic> json) {
    return LocationType(
      id: json['id'],
      name: json['name'],
    );
  }
}
