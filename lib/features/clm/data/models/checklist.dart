import 'package:fwp/features/clm/data/models/checklist_item.dart';
import 'package:fwp/features/clm/data/models/checklist_photo.dart';

class Checklist {
  final int? id;
  final int? systemId;
  int? locationTypeId;
  int? stationId;
  int? substationId;
  DateTime? date;
  String? inspectorName;
  String? description;
  List<ChecklistItem>? checklistItems; // Use lowercase for consistency
  final List<Photo>? photos;

  Checklist({
    this.id,
    this.systemId,
    this.locationTypeId,
    this.stationId,
    this.substationId,
    this.date,
    this.inspectorName,
    this.description,
    this.checklistItems, // Updated to lowercase
    this.photos,
  });

  // CopyWith method
  Checklist copyWith({
    int? id,
    int? systemId,
    int? locationTypeId,
    int? stationId,
    int? substationId,
    DateTime? date,
    String? inspectorName,
    String? description,
    List<ChecklistItem>? checklistItems, // Updated to lowercase
    List<Photo>? photos,
  }) {
    return Checklist(
      id: id ?? this.id,
      systemId: systemId ?? this.systemId,
      locationTypeId: locationTypeId ?? this.locationTypeId,
      stationId: stationId ?? this.stationId,
      substationId: substationId ?? this.substationId,
      date: date ?? this.date,
      inspectorName: inspectorName ?? this.inspectorName,
      description: description ?? this.description,
      checklistItems:
          checklistItems ?? this.checklistItems, // Updated to lowercase
      photos: photos ?? this.photos,
    );
  }

  @override
  String toString() {
    return 'Checklist(id: $id, systemId: $systemId, locationTypeId: $locationTypeId, '
        'stationId: $stationId, substationId: $substationId, '
        'description: $description, checklistItems: ${checklistItems?.length}, photos: ${photos?.length})'; // Updated to lowercase
  }

  factory Checklist.fromJson(Map<String, dynamic> json) {
    return Checklist(
      id: json['id'],
      systemId: json['system_id'],
      locationTypeId: json['location_type_id'],
      stationId: json['station_id'],
      substationId: json['substation_id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      inspectorName: json['inspector_name'],
      description: json['description'],
      checklistItems: (json['checklist_items'] as List<dynamic>?)
          ?.map((item) => ChecklistItem.fromJson(item))
          .toList(),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((item) => Photo.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'system_id': systemId,
      'location_type_id': locationTypeId,
      'station_id': stationId,
      'substation_id': substationId,
      'date': date?.toIso8601String(),
      'inspector_name': inspectorName,
      'description': description,
      'checklist_items': checklistItems
          ?.map((item) => item.toJson())
          .toList(), // Updated to lowercase
      'photos': photos?.map((photo) => photo.toJson()).toList(),
    };
  }
}
