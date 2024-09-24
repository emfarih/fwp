class ChecklistTemplateItem {
  final int? id;
  final int? checklistTemplateId;
  final String? title;
  final String? description;

  ChecklistTemplateItem({
    this.id,
    this.checklistTemplateId,
    this.title,
    this.description,
  });

  // Factory constructor to create an instance from a map (e.g., from JSON)
  factory ChecklistTemplateItem.fromMap(Map<String, dynamic> map) {
    return ChecklistTemplateItem(
      id: map['id'] as int?,
      checklistTemplateId: map['checklist_template_id'] as int,
      title: map['title'] as String?,
      description: map['description'] as String?,
    );
  }

  // Method to convert an instance to a map (e.g., for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'checklist_template_id': checklistTemplateId,
      'title': title,
      'description': description,
    };
  }
}
