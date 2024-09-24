// data/models/location.dart

class Location {
  final int id;
  final String? shortName;
  final String fullName;
  final int typeId;

  Location({
    required this.id,
    this.shortName,
    required this.fullName,
    required this.typeId,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      shortName: json['short_name'],
      fullName: json['full_name'],
      typeId: json['type_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'short_name': shortName,
      'full_name': fullName,
      'type_id': typeId,
    };
  }
}
