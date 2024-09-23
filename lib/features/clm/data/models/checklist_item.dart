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
