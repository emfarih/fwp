// models/checklist_template.dart
class ChecklistTemplate {
  final int id;
  final int systemId;
  final int? locationId;
  final String? title;
  final String? description;

  ChecklistTemplate({
    required this.id,
    required this.systemId,
    this.locationId,
    this.title,
    this.description,
  });

  factory ChecklistTemplate.fromJson(Map<String, dynamic> json) {
    return ChecklistTemplate(
      id: json['id'],
      systemId: json['system_id'],
      locationId: json['location_id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
