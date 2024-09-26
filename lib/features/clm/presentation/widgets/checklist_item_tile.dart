import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist_item.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_detail_view_model.dart';

class ChecklistItemTile extends StatelessWidget {
  final ChecklistItem checklistItem;
  final ChecklistDetailViewModel viewModel;

  const ChecklistItemTile({
    required this.checklistItem,
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(
        'ChecklistItemTile: Building tile for item ID: ${checklistItem.id}, Title: ${checklistItem.title}, Description: ${checklistItem.description}, Status: ${checklistItem.status}');

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      margin:
          const EdgeInsets.symmetric(vertical: 4.0), // Separation between items
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the title
            Text(
              checklistItem.title ?? "No Title",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            // Display the description
            Text(
              checklistItem.description ?? "No Description",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            // Checkbox options
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildCheckbox(
                    'Pass', checklistItem.status == 'pass', Colors.green,
                    (value) {
                  viewModel.updateChecklistItemStatus(
                      checklistItem.id!, value! ? 'pass' : null);
                }),
                const SizedBox(width: 8),
                _buildCheckbox(
                    'Fail', checklistItem.status == 'fail', Colors.red,
                    (value) {
                  viewModel.updateChecklistItemStatus(
                      checklistItem.id!, value! ? 'fail' : null);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox(String label, bool isChecked, Color color,
      ValueChanged<bool?>? onChanged) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
          activeColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Text(label),
      ],
    );
  }
}
