import 'package:fwp/features/clm/data/models/checklist_template_item.dart';

class ChecklistTemplate {
  final int id;
  final int systemId;
  final int locationId;
  final String? title;
  final String? description;
  List<ChecklistTemplateItem> items; // Include items

  ChecklistTemplate({
    required this.id,
    required this.systemId,
    required this.locationId,
    this.title,
    this.description,
    this.items = const [], // Default to empty list if no items are provided
  });

  // Factory constructor to create an instance from a map (e.g., from JSON)
  factory ChecklistTemplate.fromJson(Map<String, dynamic> map) {
    return ChecklistTemplate(
      id: map['id'] as int,
      systemId: map['system_id'] as int,
      locationId: map['location_id'] as int,
      title: map['title'] as String?,
      description: map['description'] as String?,
      items: map['checklist_template_items'] != null
          ? (map['checklist_template_items'] as List<dynamic>)
              .map((item) => ChecklistTemplateItem.fromMap(item))
              .toList()
          : [], // Safeguard: Provide an empty list if items are null
    );
  }

  // Method to convert an instance to a map (e.g., for saving to a database)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'system_id': systemId,
      'location_id': locationId,
      'title': title,
      'description': description,
      'checklist_template_items': items.map((item) => item.toMap()).toList(),
    };
  }
}
