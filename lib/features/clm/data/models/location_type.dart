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

enum LocationTypeEnum {
  station(1),
  substation(2);

  final int id;

  const LocationTypeEnum(this.id);

  static LocationTypeEnum? fromId(int id) {
    for (var type in LocationTypeEnum.values) {
      if (type.id == id) {
        return type;
      }
    }
    return null; // Return null if no match is found
  }
}
