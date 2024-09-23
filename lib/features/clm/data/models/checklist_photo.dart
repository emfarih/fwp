class Photo {
  final int? id;
  final int? checklistId;
  final String? photoUri;
  final String? description;

  Photo({
    this.id,
    this.checklistId,
    this.photoUri,
    this.description,
  });

  // CopyWith method
  Photo copyWith({
    int? id,
    int? checklistId,
    String? photoUri,
    String? description,
  }) {
    return Photo(
      id: id ?? this.id,
      checklistId: checklistId ?? this.checklistId,
      photoUri: photoUri ?? this.photoUri,
      description: description ?? this.description,
    );
  }

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
