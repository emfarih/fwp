import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';

class ChecklistTile extends StatelessWidget {
  final Checklist checklist;

  const ChecklistTile({super.key, required this.checklist});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(checklist.location),
      subtitle: Text('Inspection Date: ${checklist.inspectionDate.toLocal()}'),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/checklist_detail',
          arguments: checklist.id,
        );
      },
    );
  }
}
