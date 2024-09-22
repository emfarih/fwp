class ChecklistItem {
  final int? id;
  final int? checklistId; // Reference to the checklist this item belongs to
  final String? description; // Nullable description
  String? status; // "pass" or "fail"

  ChecklistItem({
    this.id,
    this.checklistId,
    this.description,
    this.status,
  });

  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      id: json['id'],
      checklistId: json['checklist_id'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'checklist_id': checklistId,
      'description': description,
      'status': status,
    };
  }
}

// Represents a photo associated with a checklist
class Photo {
  final int? id;
  final int? checklistId;
  final String? photoUri; // URL or path to the photo
  final String? description; // Nullable description

  Photo({
    this.id,
    this.checklistId,
    this.photoUri,
    this.description,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      checklistId: json['checklist_id'],
      photoUri: json['photo_uri'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'checklist_id': checklistId,
      'photo_uri': photoUri,
      'description': description,
    };
  }
}

// Checklist represents the checklist data model
class Checklist {
  final int? id;
  final int? systemId; // ID of the associated system
  int? locationTypeId; // ID of the associated location type
  int? stationId; // Pointer for nullable field
  int? substationId; // Pointer for nullable field
  final DateTime? date; // Pointer for nullable field
  final String? inspectorName; // Pointer for nullable field
  String? description; // Pointer for nullable field
  List<ChecklistItem>?
      checklistItems; // Assuming this is a defined struct elsewhere
  final List<Photo>? photos; // Assuming this is a defined struct elsewhere

  Checklist({
    this.id,
    this.systemId,
    this.locationTypeId,
    this.stationId,
    this.substationId,
    this.date,
    this.inspectorName,
    this.description,
    this.checklistItems,
    this.photos,
  });

  @override
  String toString() {
    return 'Checklist(id: $id, systemId: $systemId, locationTypeId: $locationTypeId, '
        'stationId: $stationId, substationId: $substationId, '
        'description: $description, checklistItems: ${checklistItems?.length}, photos: ${photos?.length})';
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
          .toList(), // Check for null before mapping
      photos: (json['photos'] as List<dynamic>?)
          ?.map((item) => Photo.fromJson(item))
          .toList(), // Check for null before mapping
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
      'checklist_items': checklistItems?.map((item) => item.toJson()).toList(),
      'photos': photos?.map((photo) => photo.toJson()).toList(),
    };
  }
}
