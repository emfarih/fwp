import 'package:fwp/features/clm/data/models/checklist_item.dart';
import 'package:fwp/features/clm/data/models/checklist_photo.dart';
import 'package:fwp/features/clm/utils.dart';

class Checklist {
  final int? id;
  final int? systemId;
  int? locationId;
  DateTime? date;
  String? inspectorName;
  String? title;
  String? description;
  List<ChecklistItem>? checklistItems; // Use lowercase for consistency
  final List<Photo>? photos;

  Checklist({
    this.id,
    this.systemId,
    this.locationId,
    this.date,
    this.inspectorName,
    this.title,
    this.description,
    this.checklistItems, // Updated to lowercase
    this.photos,
  });

  // CopyWith method
  Checklist copyWith({
    int? id,
    int? systemId,
    int? locationId,
    DateTime? date,
    String? inspectorName,
    String? title,
    String? description,
    List<ChecklistItem>? checklistItems, // Updated to lowercase
    List<Photo>? photos,
  }) {
    return Checklist(
      id: id ?? this.id,
      systemId: systemId ?? this.systemId,
      locationId: locationId ?? this.locationId,
      date: date ?? this.date,
      inspectorName: inspectorName ?? this.inspectorName,
      title: title ?? this.title,
      description: description ?? this.description,
      checklistItems:
          checklistItems ?? this.checklistItems, // Updated to lowercase
      photos: photos ?? this.photos,
    );
  }

  @override
  String toString() {
    return 'Checklist(id: $id, systemId: $systemId, '
        'locationId: $locationId, '
        'title: $title, description: $description, checklistItems: ${checklistItems?.length}, photos: ${photos?.length})'; // Updated to lowercase
  }

  factory Checklist.fromJson(Map<String, dynamic> json) {
    return Checklist(
      id: json['id'],
      systemId: json['system_id'],
      locationId: json['location_id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      inspectorName: json['inspector_name'],
      title: json['title'],
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
      'location_id': locationId,
      'date': date != null ? formatDateWithTimezone(date!) : null,
      'inspector_name': inspectorName,
      'title': title,
      'description': description,
      'checklist_items': checklistItems?.map((item) => item.toJson()).toList(),
      'photos': photos?.map((photo) => photo.toJson()).toList(),
    };
  }
}
