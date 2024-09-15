class Checklist {
  final int id;
  final String location;
  final DateTime inspectionDate;
  final String inspectionType;
  final String? inspectorName;
  final int photoSlots;
  final List<ChecklistItem> checklistItems;
  final List<Photo> photos;

  Checklist({
    required this.id,
    required this.location,
    required this.inspectionDate,
    required this.inspectionType,
    this.inspectorName,
    required this.photoSlots,
    required this.checklistItems,
    required this.photos,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) {
    return Checklist(
      id: json['id'],
      location: json['location'],
      inspectionDate: DateTime.parse(json['inspection_date']),
      inspectionType: json['inspection_type'],
      inspectorName: json['inspector_name'],
      photoSlots: json['photo_slots'],
      checklistItems: (json['checklist_items'] as List<dynamic>)
          .map((item) => ChecklistItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      photos: (json['photos'] as List<dynamic>)
          .map((item) => Photo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'inspection_date': inspectionDate.toIso8601String(),
      'inspection_type': inspectionType,
      'inspector_name': inspectorName,
      'photo_slots': photoSlots,
      'checklist_items': checklistItems.map((item) => item.toJson()).toList(),
      'photos': photos.map((photo) => photo.toJson()).toList(),
    };
  }
}

class ChecklistItem {
  final int id;
  final int checklistId;
  final String name;
  final String? status;

  ChecklistItem({
    required this.id,
    required this.checklistId,
    required this.name,
    this.status,
  });

  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      id: json['id'],
      checklistId: json['checklist_id'],
      name: json['name'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'checklist_id': checklistId,
      'name': name,
      'status': status,
    };
  }
}

class Photo {
  final int id;
  final int checklistId;
  final String photoUrl;
  final String? description;

  Photo({
    required this.id,
    required this.checklistId,
    required this.photoUrl,
    this.description,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      checklistId: json['checklist_id'],
      photoUrl: json['photo_url'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'checklist_id': checklistId,
      'photo_url': photoUrl,
      'description': description,
    };
  }
}
